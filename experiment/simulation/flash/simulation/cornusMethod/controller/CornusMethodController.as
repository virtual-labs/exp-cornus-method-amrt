package cornusMethod.controller{
	import cornusMethod.model.*;

	import flash.events.Event;
	import fl.events.SliderEvent;
	import flash.events.MouseEvent;

	public class CornusMethodController {
		var model:CornusMethodModel;

		var power:Boolean = new Boolean();
		var microHPosVal;
		var microVPosVal;

		public function CornusMethodController(model:CornusMethodModel) {
			// attach model
			this.model=model;
		}
		public function RadiusSlider_FN(e:SliderEvent):void {

			model.setRadiusLens(e.target.value/100);
		}
		public function BreadthSlider_FN(e:SliderEvent):void {

			model.setBreadth(e.target.value/100);
		}
		public function ThicknessSlider_FN(e:SliderEvent):void {

			model.setThickness(e.target.value/1000);
		}
		public function MassSlider_FN(e:SliderEvent):void {

			model.setMass(e.target.value/1000);
		}
		public function DistanceSlider_FN(e:SliderEvent):void {

			model.setDistance(e.target.value/100);
		}
		public function VPositionSlider_FN(e:SliderEvent):void {

			model.setVPosition(e.target.value);
		}
		public function HPositionSlider_FN(e:SliderEvent):void {

			model.setHPosition(e.target.value);
		}
		public function FineZoom_FN(e:SliderEvent) {
			if (e.target.name=="FineZoomHscale_sldr") {
				model.setHZoom(e.target.value);
			} else if (e.target.name=="FineZoomVsacle_sldr") {
				model.setVZoom(e.target.value);
			}
		}
		public function fineHorizAdjustUp(e:MouseEvent) {
			microHPosVal=model.getHPosition();
			if (microHPosVal>0) {

				microHPosVal-=.001;
			}
			model.setHPosition(microHPosVal);
		}
		public function fineHorizAdjustDown(e:MouseEvent) {
			microHPosVal=model.getHPosition();
			if (microHPosVal<15) {
				microHPosVal+=.001;
			}
			model.setHPosition(microHPosVal);
		}
		public function fineVertiAdjustUp(e:MouseEvent) {
			microVPosVal=model.getVPosition();
			if (microVPosVal>0) {

				microVPosVal-=.001;
			}
			model.setVPosition(microVPosVal);
		}
		public function fineVertiAdjustDown(e:MouseEvent) {
			microVPosVal=model.getVPosition();
			if (microVPosVal<15) {
				microVPosVal+=.001;
			}
			model.setVPosition(microVPosVal);
		}


	}
}