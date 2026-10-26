cont = 0

function split(text)
  local s, e = text:find("\n\n", 1, true)
  if s then
    return text:sub(1, s - 1), text:sub(e + 1)
  else
    return "", text
  end
end

function CodeBlock(el)
  if not el.classes:includes("sgleam_image") then
    return el
  end
  -- local name, content = el.text:match("([^\n]*)\n?(.*)")
  cont = cont + 1
  local name = "i" .. tostring(cont)
  local hide, content = split(el.text)
  local gleam = "../target/sgleam_images/" .. name .. ".gleam"
  local svg = "../target/sgleam_images/" .. name .. ".svg"
  local pdf = "../target/sgleam_images/" .. name .. ".pdf"
  os.execute("mkdir -p ../target/sgleam_images/")
  local fgleam = io.open(gleam, "w")
  fgleam:write([[
    import gleam/string
    import sgleam/image.{Point}
    import sgleam/fill
    import sgleam/stroke
    import sgleam/style
    import sgleam/color
    import sgleam/font
    import sgleam/xplace
    import sgleam/yplace
    pub fn smain() {
      let img = {
    ]]
    .. hide
    .. "\n"
    .. content:sub(2)
    .. [[

      }
      // Uma coluna e uma linha a mais, como o REPL mostra, para que o
      // contorno na borda direita e inferior não seja cortado
      image.rectangle(image.width(img) + 1, image.height(img) + 1, fill.none)
      |> image.overlay_xy(img, 0, 0, _)
      |> image.to_svg
    }
    ]]
  )
  fgleam:close()
  os.execute("cd ../ && sgleam target/" .. gleam .. " > target/" .. svg .. " 2>/dev/null")
  os.execute("rsvg-convert --format pdf1.5 --output " .. pdf .. " " .. svg)
  -- Blocos que começam com o prompt são sessões do REPL
  local class = content:match("^%s*>") and "gleam-repl" or "gleam"
  return {
    pandoc.CodeBlock(content, {class = class}),
    pandoc.Para{pandoc.Image({}, pdf)}
  }
end

