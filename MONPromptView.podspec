Pod::Spec.new do |s|
    s.name = 'MONPromptView'
    s.version = '0.0.1'
    s.summary = 'A custom simple prompt view.'
    s.platform = :ios, '7.0'
    s.license = { :type => 'MIT', :file => 'LICENSE' }
    s.homepage = 'https://github.com/mownier/MONPromptView'
    s.author = { 'Mounir Ybanez' => 'rinuom91@gmail.com' }
    s.source = { :git =>'https://github.com/mownier/MONPromptView.git', :tag => s.version.to_s }
    s.source_files = 'MONPromptView/Source/Views/MONPromptView/*.{h,m}'
    s.requires_arc = true
end
