#
#  Be sure to run `pod spec lint HongQiC229.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "HongQiC229"
  s.version      = "1.4.9"
  s.summary      = "A short description of HongQiC229."

  s.description  = <<-DESC
		   HongQi C229 Easy Fast!
                   DESC

  s.homepage     = "http://EXAMPLE/HongQiC229"

  s.license      = "Copyright (c) 2019年 HongQiC229. All rights reserved."

  s.author             = { "Wq6255169" => "327250924@qq.com" }

  s.platform     = :ios, "8.0"

  s.ios.deployment_target = "8.0"

   s.source       = { :git => "https://github.com/wyc255856/HongQiC229.git", :tag => "#{s.version}" }


   s.source_files  = "HongQiC229SDK", "HongQiC229SDKiOS/HongQiC229SDK/*.{h,m,c}"


  s.exclude_files = "Classes/Exclude"
  s.resource = "HongQiC229SDKiOS/HongQiC229SDK/HSC229CarResource.bundle"
  
  s.dependency 'SDWebImage'
end
