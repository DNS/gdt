Подключение в Adobe Flex Builder
* Скачать и установить Adobe Flash Player 11.
  o http://get.adobe.com/flashplayer/otherversions/
* Скачать последнюю версию Adobe Flex SDK (на данный момент 4.6), распаковать в любое удобное место.
  o http://opensource.adobe.com/wiki/display/flexsdk/Download+Flex+4.6
* Распаковать ZIP архив Alternativa3D 8 в любое удобное место (например, в подпапку проекта). Указать этот путь в Project->Properties->ActionScript Build Path->Library Path->Add SWC.
  o http://alternativaplatform.com/ru/download8/
* Подключить SDK, перейти в Window->Preferences->Flash Builder->Installed Flex SDKs->Add. Задать имя. После этого нажать на кнопку OK и поставить галочку около подключенной вами SDK.
* Задать дополнительные параметры проекта Project->Properties->ActionScript Compiler->Additional compiler arguments: "-swf-version=13". Также включить опцию Generate HTML wrapper file.
* В проводнике проекта открыть html-templates\<имя проекта>.html (правой кнопкой мыши ->Open With->Text Editor), указать params.wmode = "direct";.

Подключение в Adobe Flash CS4, CS5
* 11 плеер с поддержкой апи Молехилл не входит в поставку CS4, CS5

Подключение во FlashDevelop
* Скачать и установить Adobe Flash Player 11.
  o http://get.adobe.com/flashplayer/otherversions/
* Скачать последнюю версию Adobe Flex SDK (на данный момент 4.6), распаковать в любое удобное место.
  o http://opensource.adobe.com/wiki/display/flexsdk/Download+Flex+4.6
* Распаковать ZIP архив Alternativa3D 8. Скопировать файл Alternativa3D.swc в папку lib созданного проекта.
  o http://alternativaplatform.com/ru/download8/
* Открыть проект во FlashDevelop. Подключить Alternativa3D.swc к проекту, кликнув правой кнопкой мыши на пункте Add to Library.
* Указать путь к скачанному SDK: Tools->Program Settings->AS3 Context->Flex SDK Location.
* Указать в Project->Properties->Compiler Options->Additional Compiler Options: "-swf-version=13 -target-player=11.1 -static-link-runtime-shared-libraries=true".
* Открыть index.html добавить wmode: "direct" к параметрам SWFObject.

За любой технической помощью обращайтесь на наши сайты технической поддержки:
- wiki.alternativaplatform.com - вики с самой актуальной информацией по проекту
- forum.alternativaplatform.com - форум, где вы можете получить ответы от разработчиков на ваши вопросы
- http://wiki.alternativaplatform.com/Основы_Alternativa3D_8 - статья будет полезна при первом знакомстве с Alternativa3D