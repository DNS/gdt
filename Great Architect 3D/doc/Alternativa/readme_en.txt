Adobe Flex Builder connection
* Download and install the Adobe Flash Player 11.
  o http://get.adobe.com/flashplayer/otherversions/
* Download the latest version of the Adobe Flex SDK (currently 4.6) and unzip to any place.
  o http://opensource.adobe.com/wiki/display/flexsdk/Download+Flex+4.6
* Unpack the ZIP archive Alternativa3D 8 at any convenient location (for example, in a subfolder of the project). Specify the path to Project->Properties->ActionScript Build Path ->Library Path->Add SWC.
  o http://alternativaplatform.com/en/download8/
* Connect SDK, go to Window->Preferences->Flash Builder->Installed Flex SDKs->Add. Specify the name. Then press the OK button and put a tick next to your SDK.
* Set additional parameters of the project Project->Properties->ActionScript Compiler->Additional compiler arguments: "-swf-version=13". Also include the option Generate HTML wrapper file.
* In Project Explorer, open the project html-templates\<project name>.html (right click ->Open With->Text Editor), specify params.wmode = "direct";.

FlashDevelop connection
* Download and install the Adobe Flash Player 11.
  o http://get.adobe.com/flashplayer/otherversions/
* Download the latest version of the Adobe Flex SDK (currently 4.6) and unzip to any convenient place.
  o http://opensource.adobe.com/wiki/display/flexsdk/Download+Flex+4.6
* Unpack the ZIP archive Alternativa3D 8. Copy the file Alternativa3D.swc into the lib folder of created project.
  o http://alternativaplatform.com/en/download8/
* Open the project in FlashDevelop. Connect Alternativa3D.swc to the project by right-clicking on the item Add to Library.
* Specify the path to the downloaded SDK: Tools->Program Settings->AS3 Context->Flex SDK Location.
* Specify the Project->Properties->Compiler Options->Additional Compiler Options: "-swf-version=13 -target-player=11.1 -static-link-runtime-shared-libraries=true".
* Open index.html to add wmode: "direct" to the parameters of SWFObject.

For any technical assistance please contact our technical support websites:
- wiki.alternativaplatform.com - knowledge base with the latest information on the project
- forum.alternativaplatform.com - forum, where developers will answer your questions
- http://wiki.alternativaplatform.com/Alternativa3D_8_basics - the tutorial will be helpfull to people who begin to teach Alternativa3D