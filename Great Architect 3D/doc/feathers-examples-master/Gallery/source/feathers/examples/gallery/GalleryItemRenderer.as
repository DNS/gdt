package feathers.examples.gallery
{
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.display.ScrollRectManager;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class GalleryItemRenderer extends FeathersControl implements IListItemRenderer
	{
		/**
		 * @private
		 */
		private static const LOADER_CONTEXT:LoaderContext = new LoaderContext(true);

		/**
		 * @private
		 */
		private static const HELPER_POINT:Point = new Point();

		/**
		 * Constructor.
		 */
		public function GalleryItemRenderer()
		{
			this.isQuickHitAreaEnabled = true;
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
			this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, removedFromStageHandler)
		}

		/**
		 * @private
		 */
		protected var image:Image;

		/**
		 * @private
		 */
		protected var currentImageURL:String;

		/**
		 * @private
		 */
		protected var loader:Loader;

		/**
		 * @private
		 */
		protected var touchPointID:int = -1;

		/**
		 * @private
		 */
		protected var fadeTween:Tween;

		/**
		 * @private
		 */
		private var _index:int = -1;

		/**
		 * @inheritDoc
		 */
		public function get index():int
		{
			return this._index;
		}

		/**
		 * @private
		 */
		public function set index(value:int):void
		{
			if(this._index == value)
			{
				return;
			}
			this._index = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		/**
		 * @private
		 */
		protected var _owner:List;

		/**
		 * @inheritDoc
		 */
		public function get owner():List
		{
			return List(this._owner);
		}

		/**
		 * @private
		 */
		public function set owner(value:List):void
		{
			if(this._owner == value)
			{
				return;
			}
			if(this._owner)
			{
				this._owner.removeEventListener(starling.events.Event.SCROLL, owner_scrollHandler);
			}
			this._owner = value;
			if(this._owner)
			{
				this._owner.addEventListener(starling.events.Event.SCROLL, owner_scrollHandler);
			}
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		/**
		 * @private
		 */
		private var _data:GalleryItem;

		/**
		 * @inheritDoc
		 */
		public function get data():Object
		{
			return this._data;
		}

		/**
		 * @private
		 */
		public function set data(value:Object):void
		{
			if(this._data == value)
			{
				return;
			}
			this.touchPointID = -1;
			this._data = GalleryItem(value);
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		/**
		 * @private
		 */
		private var _isSelected:Boolean;

		/**
		 * @inheritDoc
		 */
		public function get isSelected():Boolean
		{
			return this._isSelected;
		}

		/**
		 * @private
		 */
		public function set isSelected(value:Boolean):void
		{
			if(this._isSelected == value)
			{
				return;
			}
			this._isSelected = value;
			this.dispatchEventWith(starling.events.Event.CHANGE);
		}

		/**
		 * @private
		 */
		override public function dispose():void
		{
			if(this.image)
			{
				this.clearImage();
			}
			super.dispose();
		}

		/**
		 * @private
		 */
		override protected function draw():void
		{
			const dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);
			const selectionInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SELECTED);
			var sizeInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SIZE);

			if(dataInvalid)
			{
				if(this._data)
				{
					if(this.currentImageURL != this._data.thumbURL)
					{
						if(this.loader)
						{
							this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loader_completeHandler);
							this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
							this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
							try
							{
								this.loader.close();
							}
							catch(error:Error)
							{
								//no need to do anything in response
							}
							this.loader = null;
						}

						if(this.image)
						{
							this.image.visible = false;
						}

						if(this.fadeTween)
						{
							Starling.juggler.remove(this.fadeTween);
							this.fadeTween = null;
						}

						this.currentImageURL = this._data.thumbURL;
						this.loader = new Loader();
						this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_completeHandler);
						this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
						this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
						this.loader.load(new URLRequest(this._data.thumbURL), LOADER_CONTEXT);
					}
				}
				else
				{
					if(this.loader)
					{
						this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loader_completeHandler);
						this.loader = null;
					}
					if(this.image)
					{
						this.clearImage();
					}
					this.currentImageURL = null;
				}
			}

			sizeInvalid = this.autoSizeIfNeeded() || sizeInvalid;

			if(sizeInvalid)
			{
				if(this.image)
				{
					this.image.x = (this.actualWidth - this.image.width) / 2;
					this.image.y = (this.actualHeight - this.image.height) / 2;
				}
			}
		}

		/**
		 * @private
		 */
		protected function autoSizeIfNeeded():Boolean
		{
			const needsWidth:Boolean = isNaN(this.explicitWidth);
			const needsHeight:Boolean = isNaN(this.explicitHeight);
			if(!needsWidth && !needsHeight)
			{
				return false;
			}
			var newWidth:Number = this.explicitWidth;
			if(needsWidth)
			{
				if(this.image)
				{
					newWidth = this.image.width;
				}
				else
				{
					newWidth = 100;
				}
			}
			var newHeight:Number = this.explicitHeight;
			if(needsHeight)
			{
				if(this.image)
				{
					newHeight = this.image.height;
				}
				else
				{
					newHeight = 100;
				}
			}
			return this.setSizeInternal(newWidth, newHeight, false);
		}

		/**
		 * @private
		 */
		protected function clearImage():void
		{
			this.image.texture.dispose();
			this.removeChild(this.image, true);
			this.image = null;
		}

		/**
		 * @private
		 */
		protected function removedFromStageHandler(event:starling.events.Event):void
		{
			this.touchPointID = -1;
		}

		/**
		 * @private
		 */
		protected function touchHandler(event:TouchEvent):void
		{
			const touches:Vector.<Touch> = event.getTouches(this);
			if(touches.length == 0)
			{
				return;
			}
			if(this.touchPointID >= 0)
			{
				var touch:Touch;
				for each(var currentTouch:Touch in touches)
				{
					if(currentTouch.id == this.touchPointID)
					{
						touch = currentTouch;
						break;
					}
				}
				if(!touch)
				{
					return;
				}
				if(touch.phase == TouchPhase.ENDED)
				{
					this.touchPointID = -1;

					touch.getLocation(this, HELPER_POINT);
					ScrollRectManager.adjustTouchLocation(HELPER_POINT, this);
					if(this.hitTest(HELPER_POINT, true) != null && !this._isSelected)
					{
						this.isSelected = true;
					}
					return;
				}
			}
			else
			{
				for each(touch in touches)
				{
					if(touch.phase == TouchPhase.BEGAN)
					{
						this.touchPointID = touch.id;
						return;
					}
				}
			}
		}

		/**
		 * @private
		 */
		protected function owner_scrollHandler(event:starling.events.Event):void
		{
			this.touchPointID = -1;
		}

		/**
		 * @private
		 */
		protected function loader_completeHandler(event:Event):void
		{
			const bitmap:Bitmap = Bitmap(this.loader.content);
			this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loader_completeHandler);
			this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
			this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
			this.loader = null;

			const texture:Texture = Texture.fromBitmap(bitmap);
			if(this.image)
			{
				this.image.texture.dispose();
				this.image.texture = texture;
				this.image.readjustSize();
			}
			else
			{
				this.image = new Image(texture);
				this.addChild(this.image);
			}
			this.image.alpha = 0;
			this.image.visible = true;
			this.fadeTween = new Tween(this.image, 0.25, Transitions.EASE_OUT);
			this.fadeTween.fadeTo(1);
			Starling.juggler.add(this.fadeTween);
			this.invalidate(INVALIDATION_FLAG_SIZE);
		}

		/**
		 * @private
		 */
		protected function loader_errorHandler(event:ErrorEvent):void
		{
			this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loader_completeHandler);
			this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
			this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
			this.loader = null;

			//can't load the image at this time
			//TODO: maybe show a placeholder?
		}

	}
}
