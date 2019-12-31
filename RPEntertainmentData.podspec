
Pod::Spec.new do |spec|

  spec.name         = "RPEntertainmentData"
  spec.version      = "0.0.8"
  spec.summary      = "Dependencia encargada de persistir los modelos del negocio"
  

  spec.description  = <<-DESC
  Modulo encargado de procesar el CRUD completo sobre persistencia local, al dominio del negocio Movie y Tv
                   DESC


  spec.homepage     = "https://github.com/javierbc121086/KEntertainmentData"
  spec.license      = { :type => "MIT", :file => "LICENSE" }


  spec.author             = { "Javier Bolaños Carapia" => "javier.bc121086@gmail.com" }
  spec.social_media_url   = "https://www.linkedin.com/in/javier-bola%C3%B1os-carapia-47b079152/"

  
  spec.platform     = :ios
  spec.ios.deployment_target = "10.0"


  spec.source       = { :git => "git@github.com:javierbc121086/KEntertainmentData.git", :tag => "#{spec.version}" }
  

  spec.source_files  = "RPEntertainmentData", "RPEntertainmentData/**/*.{h,m,swift}"
  spec.exclude_files = "Classes/Exclude"
  spec.resource = "RPEntertainmentData/CoreDataModel/RPECoreDataModel.xcdatamodeld"

  spec.swift_versions = "5.1.3"
  spec.requires_arc = true


  spec.dependency "KEntertainmentDomain"

end

## Release New Pod ##
# git tag -a 0.0.8 -m "Pod V0.0.8"
# git push --tags

# pod repo push KEntertainmentDataSpec RPEntertainmentData.podspec --allow-warnings --sources='https://github.com/CocoaPods/Specs.git,git@github.com:javierbc121086/KEntertainmentDomainSpec.git' --private --verbose