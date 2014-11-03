
Pod::Spec.new do |s|
  s.name         = "VGHtmlParser"
  s.version      = "0.1.0"
  s.summary      = "Simple HTML to NSAttributedString parser. Based on hpple"
  s.description  = <<-DESC
                   HTML to NSAttributeString parser
The idea behind is to have fast and customizable HTML to NSAttributedString parser.
Project is based on **hpple** library. See: https://github.com/topfunky/hpple.
                   DESC
  s.homepage     = "https://github.com/dynbit/VGHtmlParser"
  s.license      = "Apache License, Version 2.0"
  s.author             = { "Vytautas Galaunia" => "vytautas.galaunia@gmail.com" }
  s.social_media_url   = "http://twitter.com/dynbit"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/dynbit/VGHtmlParser.git", :tag => "0.1.0" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.requires_arc = true
  s.dependency "hpple", "~> 0.2.0"
end