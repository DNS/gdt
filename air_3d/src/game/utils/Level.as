package game.utils {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.loaders.ParserCollada;
	
	public class Level {
		private var parser:ParserCollada = new ParserCollada();
		private var toLoad:Array = new Array();
		
		public var levelId:int = 0;
		public var objects:Array = new Array();
		
		public function Level(_data:XML) {
			levelId = int(_data.@id);
			//parse(_data);
			trace("id: " + levelId);
			
			// floor
			var floor:Object3D = parseObject(_data.stage.floor.object);
			
			}
		//
		private function parseObject(objData:XMLList):Object3D {
			var obj:Object3D = null;
			trace("parse: " + objData);
			//var path:String = Application.assets.getAsset(objData.mesh.@id).path;
			//parser.parse()
			//trace("path: " + path);
			
			return obj;
			}
	}
}