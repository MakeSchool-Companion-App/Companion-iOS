# Uncomment the next line to define a global platform for your project

 platform :ios, '9.0'

 use_frameworks!
def dev_pods
    pod 'iBeaconManager', '0.1.0'
    pod 'KeychainSwift', '~> 13.0'
    pod 'NVActivityIndicatorView'
    pod 'Kingfisher','~> 4.10.1'
end

 # Pods for companion
target 'companion' do
 
  dev_pods
 
  target 'companionTests' do
    inherit! :search_paths
    # Pods for testing
  end
end

target 'companion Dev' do
    
     pod 'iBeaconManager', '0.1.0'
     pod 'KeychainSwift', '~> 13.0'
     pod 'NVActivityIndicatorView'
    end
