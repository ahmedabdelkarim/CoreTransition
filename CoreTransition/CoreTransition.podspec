Pod::Spec.new do |spec|
  spec.name         = "CoreTransition"
  spec.version      = "1.1"
  spec.summary      = "iOS framework for impressive transition animations between views."
  spec.description  = "iOS framework for impressive transition animations between views. Built using Swift, and supports a lot of animations to navigate to a view or back to the first view."
  spec.homepage     = "https://github.com/ahmedabdelkarim/CoreTransition"
  spec.license      = "MIT"
  
  spec.author             = { "Ahmed Abdelkarim" => "ahmed.karim.tantawy@live.com" }
  spec.social_media_url   = "https://www.linkedin.com/in/ahmedabdelkarim"

  spec.platform     = :ios, "14.3"
  spec.swift_versions = "5.0"

  spec.source       = { :git => "https://github.com/ahmedabdelkarim/CoreTransition.git", :tag => spec.version.to_s }

  spec.source_files  = "CoreTransition/**/*.{swift}"
 
end
