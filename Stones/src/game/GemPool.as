package game {
    import game.gems.BaseGem

    public class GemPool extends Object {
        private var mPool:Vector.<BaseGem>;
        private var mIndex:int = 0;

        public function GemPool() {
            this.mPool = new Vector.<BaseGem>;
            return;
			}
		
        public function Reset():void {
            this.mIndex = 0;
            return;
			}
		
        public function GetGem():BaseGem {
            if (this.mIndex >= this.mPool.length) {
                this.mPool[this.mIndex] = new BaseGem();
				}
            var _loc_1:* = this.mPool[this.mIndex];
            _loc_1.Reset();
            var _loc_2:String = this;
            var _loc_3:* = this.mIndex + 1;
            _loc_2.mIndex = _loc_3;
            return _loc_1;
			}
    }
}
