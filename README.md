# :camera_flash: Intelligent Camera
This is a flutter app which detects objects smartly in the camera.


# :clapper: App Demonstration
<img src = "https://user-images.githubusercontent.com/97830682/224579560-2f5c6b2b-9f75-4196-952b-3b81e614fc48.jpg" width="300"/>&nbsp;&nbsp;&nbsp;<img src = "https://user-images.githubusercontent.com/97830682/224579567-8cea0e40-55fc-4370-8bd7-35fbc94feddf.jpg" width="300"/>&nbsp;&nbsp;&nbsp;<img src = "https://user-images.githubusercontent.com/97830682/224579586-f4a69081-1f52-4ef2-9df5-5990fd05ca26.jpg" width="300"/>&nbsp;&nbsp;&nbsp;<img src = "https://user-images.githubusercontent.com/97830682/224579590-b24126bd-7eee-4ebc-862e-b3cc11b56c6f.jpg" width="300"/>&nbsp;&nbsp;&nbsp;<img src = "https://user-images.githubusercontent.com/97830682/224579601-470dde17-deac-41f6-8909-dd4d9ff15cf9.jpg" width="300"/>&nbsp;&nbsp;&nbsp;<img src = "https://user-images.githubusercontent.com/97830682/224579606-67f6bc70-5834-4ca3-849c-45f78bc65d85.jpg" width="300"/>


### Video Demonstration for the same -->

https://user-images.githubusercontent.com/97830682/224581185-5b03d30e-1d35-498a-b958-a75f618e82f0.mp4
 


# :question: Problem Statement
Language: Flutter Must work in: Android, iOS (OK if you can just test in one, but we will test in both and if it doesn't work we'll send you the debug info so you can fix it).

Write a Flutter app that lets you take pictures of anything and autozooms to the right size to pick up an object that is in view. For example: Take a collection of dogs, or cats (there are probably pretrained models for this, it's up to you to look them up). If your app is used to take a picture of a dog, then the zoom should be automatically adjusted to take a picture of the dog in foreground, even if the dog is a bit far.

It must be fast or the dog will move!

# :bulb: Solution
This app detects objects in live camera stream providng a constrained layout on them , once image is clicked it provides zoomed out image of all the objects detected and an option to save each of the zoomed out images .


#  :desktop_computer: Technologies Used


<ul>

  <li>  <img src= "https://user-images.githubusercontent.com/97830682/224580530-8b279566-92b2-4ceb-be41-b0b8b394a153.svg" width = "20"/> Flutter & Dart
</li>



  <li> <img src= "https://user-images.githubusercontent.com/97830682/224580546-43b229b2-0bd1-4821-aa9a-5e0c426e0265.svg" width = "20"/>    Object Detection Model --> Pre-Trained SSD MobileNet Model on TensorFlowLite</li>
</ul>  


    
 ## Flutter Packages Used
 <ul>
  <li>Camera: enables to use device camera</li>
  <li>tflite: enabled importing and loading of pre trained tensorflowlite models</li>
  <li>image: brings about certain APIs to perform image manipulation in point size format as so returned by the model</li>
  <li>image_gallery_saver: provides the functionality to save image in gallery </li>
</ul>  
 

  
# :gear: How to Setup the Application

### 1: Clone the repository

<pre>git clone https://github.com/GeekyPS/Intelligent-Camera.git </pre>


### 2: Specifying the path in the terminal

<pre>cd location_of_the_folder </pre>

### 3: Getting the Packages

<pre>flutter pub get </pre>

## 4: Running the Application

<pre>flutter run </pre>
Note: Run the Application on physical device, emulators don't support camera


# :warning: Issue with tflite package (IMPORTANT)

Disclaimer: tflite package was last updated 23 months ago as of 13th march,2023. So needless to say , it have some problems with newer flutter versions , so here are the fixes for them


#### Issue 1: Could not find method compile() for arguments `[org. tensorflow:tensorflow-lite:+]` on object of type `org.gradle.api.internal.artifacts.ds1.dependencies.DefaultDependencyHandler` in Android.
![image](https://user-images.githubusercontent.com/97830682/224578911-4374a0ba-6221-4696-bb2c-d1450c850528.png)
This is a lethal issue with `tflite` package that it uses the older syntax of compile() which is completed removed in versions of gradle after 7.0.0.

To resolve this, simply replace `compile` with `impelementaion` in build.gradle your system's pub cache(Note: not in the flutter's android folder).Location of pub cache is visible in the error message, in my case its '/Users/priyanshu/-pub-cache/hosted/pub.dev/tflite-1.1.2/android/build.gradle'
Also this is the reason for failure of workflow code in github to auto-generate apk.

`Earlier`

![image](https://user-images.githubusercontent.com/97830682/224579105-96037ed8-7d73-443e-bb8a-b79679f9c48b.png)


`After`

![image](https://user-images.githubusercontent.com/97830682/224579119-2b25163d-802f-4dce-b518-45144b59791c.png)



#### Issue 2: The plugin `tflite` uses a deprecated version of the Android embedding in Android.

![image](https://user-images.githubusercontent.com/97830682/224578737-e58ea7bf-a8b5-4192-84ea-1d26b41d62dd.png)

This is a warning and can be harmlessly ignored for the time being, if the older version of android embedding is removed in some flutter version , downgrade flutter to 

<ul>
<li>Flutter: 3.7.7 </li>
<li> Channel: Stable</li>
</ul>


# :vibration_mode: Bundled Apk for the App

https://drive.google.com/file/d/1N2nsjb4TcDvfczFl7_hzerraxoOBKpEI/view?usp=sharing


# :level_slider: Limitations

<ul>
  <li>App is limited by the correctness of the ML model used , in ./assets </li>
  <li>App is also limited by the camera quality of the device</li>
</ul>  





