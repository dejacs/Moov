platform :ios, '13.0'

use_frameworks!

workspace 'Moov'

# network_module
def network_pods
    # some pod
end

target 'Network' do
  project 'Network/Network.project'
  network_pods
end


# application
def application_pods
    network_pods
end

target 'Moov' do
  project 'Moov.project'
  application_pods

  target 'MoovTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MoovUITests' do
    # Pods for testing
  end
end