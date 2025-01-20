# Uncomment the next line to define a global platform for your project
# platform :ios, '18.0'

target 'RateAndReview' do
  # Comment the next line if you don't want to use dynamic frameworks
  source 'https://cdn.cocoapods.org/'
  source 'https://repo.backbase.com/artifactory/api/pods/pods'
  use_frameworks!

  # Pods for RateAndReview
  # $resolverVersion = '1.2.1'
  # $backbaseVersion = '~> 12.0'
  # $designSystemVersion = '~> 6.0'

  pod 'Backbase'
  pod 'SwiftLint'
#  pod 'Resolver'
  pod 'BackbaseDesignSystem'

  target 'RateAndReviewTests' do
#    inherit! :search_paths
    # Pods for testing
  end

  target 'RateAndReviewUITests' do
    # Pods for testing
  end

end

post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    
    if target.respond_to?(:product_type)
      if target.product_type == "com.apple.product-type.bundle"
        target.build_configurations.each do |config|
          config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
        end
      end
    end
    
    target.build_configurations.each do |config|
      if config.name.include?("Debug")
        config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
      end
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      # Our frameworks are built with library evolution support enabled,
      # and they are linked against dependencies with the same setting.
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
end
