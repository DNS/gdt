package feathers.examples.layoutExplorer.screens
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.examples.layoutExplorer.data.TiledColumnsLayoutSettings;
	import feathers.layout.TiledColumnsLayout;

	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Event;

	[Event(name="complete",type="starling.events.Event")]

	[Event(name="showSettings",type="starling.events.Event")]

	public class TiledColumnsLayoutScreen extends Screen
	{
		public static const SHOW_SETTINGS:String = "showSettings";

		public function TiledColumnsLayoutScreen()
		{
			super();
		}

		public var settings:TiledColumnsLayoutSettings;

		private var _container:ScrollContainer;
		private var _header:Header;
		private var _backButton:Button;
		private var _settingsButton:Button;

		override protected function initialize():void
		{
			const layout:TiledColumnsLayout = new TiledColumnsLayout();
			layout.paging = this.settings.paging;
			layout.gap = this.settings.gap;
			layout.paddingTop = this.settings.paddingTop;
			layout.paddingRight = this.settings.paddingRight;
			layout.paddingBottom = this.settings.paddingBottom;
			layout.paddingLeft = this.settings.paddingLeft;
			layout.horizontalAlign = this.settings.horizontalAlign;
			layout.verticalAlign = this.settings.verticalAlign;
			layout.tileHorizontalAlign = this.settings.tileHorizontalAlign;
			layout.tileVerticalAlign = this.settings.tileVerticalAlign;

			this._container = new ScrollContainer();
			this._container.layout = layout;
			this._container.scrollerProperties.snapToPages = this.settings.paging != TiledColumnsLayout.PAGING_NONE;
			this._container.scrollerProperties.snapScrollPositionsToPixels = true;
			this.addChild(this._container);
			for(var i:int = 0; i < this.settings.itemCount; i++)
			{
				var size:Number = (44 + 88 * Math.random()) * this.dpiScale;
				var quad:Quad = new Quad(size, size, 0xff8800);
				this._container.addChild(quad);
			}

			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

			this._settingsButton = new Button();
			this._settingsButton.label = "Settings";
			this._settingsButton.addEventListener(Event.TRIGGERED, settingsButton_triggeredHandler);

			this._header = new Header();
			this._header.title = "Tiled Columns Layout";
			this.addChild(this._header);
			this._header.leftItems = new <DisplayObject>
			[
				this._backButton
			];
			this._header.rightItems = new <DisplayObject>
			[
				this._settingsButton
			];

			// handles the back hardware key on android
			this.backButtonHandler = this.onBackButton;
		}

		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();

			this._container.y = this._header.height;
			this._container.width = this.actualWidth;
			this._container.height = this.actualHeight - this._container.y;
		}

		private function onBackButton():void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}

		private function backButton_triggeredHandler(event:Event):void
		{
			this.onBackButton();
		}

		private function settingsButton_triggeredHandler(event:Event):void
		{
			this.dispatchEventWith(SHOW_SETTINGS);
		}
	}
}
