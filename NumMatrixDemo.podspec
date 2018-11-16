Pod::Spec.new do |s|

  s.name         = "NumMatrixDemo"
  s.version      = "1.2"
  s.summary      = "caculate sudoku results"
  s.description  = <<-DESC
  caculate sudoku results.
                   DESC

  s.homepage     = "https://github.com/chkm/NumMatrixDemo"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "ckm" => "kaiminchen@126.com" }
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/chkm/NumMatrixDemo.git", :tag => "#{s.version}" }
  s.source_files  = "NumMatrixDemo/**/*.{h,m}"
  s.public_header_files = 'JSONModel/**/*.h'
  s.exclude_files = "Classes/Exclude"

  s.requires_arc = true

end
