package cornusMethod.model{

	import cornusMethod.model.*;
	import cornusMethod.view.*;
	import cornusMethod.controller.*;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.display.MovieClip;

	public class CornusMethodModel extends EventDispatcher {

		public static const UPDATE:String='update';

		var YoungsModulus:Number=3200000000;
		var λ=5893*Math.pow(10,-10);//λ
		var g=9.8;
		var σ=0.5;//σ
		var radiusLens:Number;
		var breadth:Number;
		var thickness:Number;
		var mass:Number;
		var distance:Number;
		var vPosition:Number;
		var hPosition:Number;
		var R1:Number;
		var R2:Number;
		var Diameter:Number;
		var dn1:Number;
		var dn11:Number;
		var hZoom:Number;
		var vZoom:Number;
		var Ellipse:MovieClip=new MovieClip  ;
		var light:Boolean =new Boolean();
		public function CornusMethodModel() {
			//create the data model
		}
		//
		public function setRadiusLens(radiusLens:Number) {
			this.radiusLens=radiusLens;
		}
		public function getRadiusLens():Number {
			return radiusLens;
		}
		public function setBreadth(breadth:Number) {
			this.breadth=breadth;
		}
		public function getBreadth():Number {
			return breadth;
		}
		public function setThickness(thickness:Number) {
			this.thickness=thickness;
		}
		public function getThickness():Number {
			return thickness;
		}
		public function setMass(mass:Number) {
			this.mass=mass;
		}
		public function getMass():Number {
			return mass;
		}
		public function setDistance(distance :Number) {
			this.distance=distance;
		}
		public function getDistance():Number {
			return distance;
		}
		public function setVPosition(vPosition :Number) {
			this.vPosition=vPosition;
			//notifyObservers();
		}
		public function getVPosition():Number {
			return vPosition;
		}
		public function setHPosition(hPosition :Number) {
			this.hPosition=hPosition;
			//notifyObservers();
		}
		public function getHPosition():Number {
			return hPosition;
		}
		public function setLightOn(light:Boolean) {
			this.light=light;
		}
		public function getLightOn():Boolean {
			return light;
		}
		public function setHZoom(hZoom:Number) {
			this.hZoom=hZoom;
		}
		public function getHZoom():Number {
			return hZoom;
		}
		public function setVZoom(vZoom:Number) {
			this.vZoom=vZoom;
		}
		public function getVZoom():Number {
			return vZoom;
		}
		public function findR1():Number {

			R1=(YoungsModulus*getBreadth()*getThickness()*getThickness()*getThickness())/(12*getMass()*g*getDistance());
			return R1;

		}
		public function findR2():Number {

			var r1=findR1();
			R2=r1/σ;
			return R2;

		}
		public function findDiameter(n:Number,R:Number):Number {

			var NthDiameterSqr=λ*n*getRadiusLens()/4;	/*    dn^2 (m^2)   */
			var a=1/(R*4*λ*n);							//     1/R1*4*λ*n
			var NthDiameterSqrRecpcl=1/NthDiameterSqr; /*      1/dn^2       */
			var DiameterSqrRecpcl=a+NthDiameterSqrRecpcl;
			Diameter=(Math.sqrt(1/DiameterSqrRecpcl))*100;
			return Diameter;


		}
		public function findDiameterWidth(n:Number):Number {
			dn1=findDiameter(n,findR1());
			return dn1;
		}
		public function findDiameterHeight(n:Number):Number {
			dn11=findDiameter(n,findR2());
			return dn11;
		}

		function notifyObservers():void {
			// broadcastMessage
			dispatchEvent(new Event(CornusMethodModel.UPDATE));
		}
	}
}