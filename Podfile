# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'WhereRU' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WhereRU

post_install do |installer|
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      end
  end
end

	# Firebase
	pod 'FirebaseAuth'
	pod 'FirebaseFirestore'
	pod 'FirebaseStorage'

	# Kakao
	pod 'KakaoSDKFriend'
	pod 'KakaoSDKTalk'

	# FloatingPanel
	pod 'FloatingPanel'

# Pods for kakaoTestApp

	target 'WhereRUTests' do
	inherit! :search_paths
# Pods for testing
	end

	target 'WhereRUUITests' do
		# Pods for testing
	end

end
