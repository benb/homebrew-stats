require 'formula'

class Minibuola < Formula
  homepage 'http://www.csc.kth.se/~chengz/TopicModelCode.html'
  url 'http://www.csc.kth.se/~chengz/minibuola.tar.gz'
  sha1 '183e826966b22f3d2419fe70f400f4671a59ffb2'
  version '0.1'

  depends_on 'cmake' => :build
  depends_on 'eigen'
  depends_on 'dbus'
  depends_on 'gettext'
  depends_on 'nlopt'
  depends_on 'boost'
  
  def patches; DATA; end

  def install
    cd 'build/' do 
      system "cmake", "..",  *std_cmake_args
      system "make"
      system "make install"
    end
  end

  test do
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index f6708ff..583b92e 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -17,6 +17,9 @@ include(BuolaDefaults)
 include(BuolaInstallDirs)

 find_package(Eigen3 REQUIRED)
+find_package(Boost COMPONENTS system chrono)
+find_package(Gettext REQUIRED)
+find_path(INTL_INCLUDE_DIR libintl.h)

 include_directories(
             ${CMAKE_SOURCE_DIR}/include
@@ -25,6 +28,7 @@ include_directories(

 include_directories(SYSTEM
             ${EIGEN3_INCLUDE_DIR}
+            ${INTL_INCLUDE_DIR}
 )

 if(BUOLA_PLATFORM_MAC)
