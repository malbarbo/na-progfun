function CodeBlock(el)
  if el.classes:includes("sgleam_image") then
    local name, content = el.text:match("([^\n]*)\n?(.*)")
    local gleam = "../target/sgleam_images/" .. name .. ".gleam"
    local svg = "../target/sgleam_images/" .. name .. ".svg"
    local pdf = "../target/sgleam_images/" .. name .. ".pdf"
    os.execute("mkdir -p ../target/sgleam_images/")
    local fgleam = io.open(gleam, "w")
    fgleam:write([[
      import sgleam/image
      import sgleam/fill
      import sgleam/stroke
      import sgleam/color
      import gleam/io
      pub fn main() {
      ]]
      .. content:sub(2)
      .. "|> image.to_svg |> io.println"
      ..
      "}"
    )
    fgleam:close()
    os.execute("cd ../ && sgleam target/" .. gleam .. " > target/" .. svg .. " 2> /dev/null")
    os.execute("inkscape --pipe --export-type=pdf --export-filename=" .. pdf .. " " .. svg .. " 2> /dev/null")
    return {
      pandoc.CodeBlock(content, {class = "gleam"}),
      pandoc.Para{pandoc.Image({}, pdf)}
    }
  end
  return el
end
