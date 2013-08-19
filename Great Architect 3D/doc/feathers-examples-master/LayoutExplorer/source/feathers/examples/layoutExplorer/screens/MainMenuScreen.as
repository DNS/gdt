package feathers.examples.layoutExplorer.screens
{
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.skins.StandardIcons;

	import starling.events.Event;

	[Event(name="showHorizontal",type="starling.events.Event")]

	[Event(name="showVertical",type="starling.events.Event")]

	[Event(name="showTiledRows",type="starling.events.Event")]

	[Event(name="showTiledColumns",type="starling.events.Event")]

	public class MainMenuScreen extends Screen
	{
		public static const SHOW_HORIZONTAL:String = "showHorizontal";
		public static const SHOW_VERTICAL:String = "showVertical";
		public static const SHOW_TILED_ROWS:String = "showTiledRows";
		public static const SHOW_TILED_COLUMNS:String = "showTiledColumns";

		public function MainMenuScreen()
		{
			super();
		}

		private var _header:Header;
		private var _list:List;

		override protected function initialize():void
		{
			this._list = new List();
			this._list.dataProvider = new ListCollection(
			[
				{ text: "Horizontal", accessoryTexture: StandardIcons.listDrillDownAccessoryTexture, event: SHOW_HORIZONTAL },
				{ text: "Vertical", accessoryTexture: StandardIcons.listDrillDownAccessoryTexture, event: SHOW_VERTICAL },
				{ text: "Tiled Rows", accessoryTexture: StandardIcons.listDrillDownAccessoryTexture, event: SHOW_TILED_ROWS },
				{ text: "Tiled Columns", accessoryTexture: StandardIcons.listDrillDownAccessoryTexture, event: SHOW_TILED_COLUMNS },
			]);
			this._list.itemRendererProperties.labelField = "text";
			this._list.itemRendererProperties.accessoryTextureField = "accessoryTexture";
			this._list.addEventListener(Event.CHANGE, list_changeHandler);
			this.addChild(this._list);

			this._header = new Header();
			this._header.title = "Layouts in Feathers";
			this.addChild(this._header);
		}

		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();

			this._list.y = this._header.height;
			this._list.width = this.actualWidth;
			this._list.height = this.actualHeight - this._list.y;
		}

		private function list_changeHandler(event:Event):void
		{
			const eventType:String = this._list.selectedItem.event as String;
			this.dispatchEventWith(eventType);
		}
	}
}
