require 'rubygems'
require 'RMagick'
include Magick

resultFileName = "./images/result.png"

result = Image.from_blob(File.read("./images/kazoo_origin_bg.png")).shift.resize(128,128)
img = Image.from_blob(File.read("./images/quco.png")).shift.resize(128,128)
result = result.composite(img, 0, 0, OverCompositeOp)

result.write(resultFileName)
