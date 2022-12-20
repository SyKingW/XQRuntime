Pod::Spec.new do |s|
s.name         = "XQRuntime"      #SDK名称
s.version      = "0.0.1"                        #版本号
s.homepage     = "https://github.com/SyKingW/XQRuntime"  #工程主页地址
s.summary      = "简单的描述."  #项目的简单描述
s.license     = "MIT"  #协议类型
s.author       = { "王兴乾" => "1034439685@qq.com" } #作者及联系方式
s.platform     = :ios  #支持的平台
s.platform     = :ios, "8.0"   #平台及版本
s.ios.deployment_target = "8.0"     #最低系统版本
s.source       = { :git => "https://github.com/SyKingW/XQRuntime.git" ,:tag => "#{s.version}"}   #工程地址及版本号
s.requires_arc = true   #是否必须arc
s.source_files = "XQRuntime/XQRuntime/*.{h,m,swift}"

#s.frameworks   = "UIKit","Foundation"    #需要导入的frameworks名称，注意不要带上frameworks
#s.dependency "AFNetworking" #依赖的第三方库

end

