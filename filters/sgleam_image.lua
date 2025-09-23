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
    import sgleam/image.{Point}
    import sgleam/fill
    import sgleam/stroke
    import sgleam/style
    import sgleam/color
    import sgleam/font
    import sgleam/xplace
    import sgleam/yplace
    import gleam/io
    pub fn main() {
    ]]
    .. hide
    .. content:sub(2)
    .. [[

    |> image.to_svg |> io.println
    ]]
    ..
    "}"
  )
  fgleam:close()
  os.execute("cd ../ && sgleam target/" .. gleam .. " > target/" .. svg)
  os.execute("rsvg-convert --format pdf1.5 --output " .. pdf .. " " .. svg)
  return {
    pandoc.CodeBlock(content, {class = "gleam"}),
    pandoc.Para{pandoc.Image({}, pdf)}
  }
end

