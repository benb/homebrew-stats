require 'formula'
class Topicmodel < Formula
  homepage 'http://www.csc.kth.se/~chengz/TopicModelCode.html'
  url 'http://www.csc.kth.se/~chengz/TopicModel.tar.gz'
  sha1 '5a50855758092f36628eb15dbd77fc5d10d158c9'

  version '0.1'

  depends_on "cmake"
  depends_on "eigen"
  depends_on "benb/stats/minibuola"
  depends_on "gsl"

  def patches; DATA; end

  def install
    mkdir 'build' do
      system "pwd"
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
index 37680ad..d4bcdd6 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -4,7 +4,7 @@ cmake_policy(VERSION 2.8.0)
 project(TopicModel)

 find_package(MiniBuola REQUIRED)
-#find_package(Eigen3 REQUIRED)
+find_package(Eigen3 REQUIRED)

 #include_directories(SYSTEM
 #            ${EIGEN3_INCLUDE_DIR}
@@ -12,6 +12,10 @@ find_package(MiniBuola REQUIRED)

 #FILE(GLOB_RECURSE cc_sources *.cc)
 set(cc_sources ccorpus.cc cmodel.cc main.cc opt.cc)
+#
+include_directories(SYSTEM
+  ${EIGEN3_INCLUDE_DIR}
+)

 add_executable(TopicModel ${cc_sources})
 add_definitions(-std=c++11 -DNDEBUG)
diff --git a/ccorpus.cc b/ccorpus.cc
index 6518a08..538506d 100644
--- a/ccorpus.cc
+++ b/ccorpus.cc
@@ -34,6 +34,7 @@
 #include <buola/functors/predicates/char.h>
 #include <buola/io/lines.h>
 #include <fstream>
+#include <numeric>

 namespace buola { namespace hdp {

