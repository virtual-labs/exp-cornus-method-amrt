package cornusMethod.view{
	import cornusMethod.*;
	import cornusMethod.model.*;
	import cornusMethod.view.*;
	import cornusMethod.controller.*;
	import flash.display.MovieClip;
	import fl.lang.Locale;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import fl.controls.ComboBox;
	import flash.events.MouseEvent;
	import fl.controls.Slider;
	import fl.events.SliderEvent;
	import fl.controls.Button;
	import fl.controls.CheckBox;
	import fl.controls.Label;
	import flash.geom.ColorTransform;

	public class CornusMethodView {
		var model:CornusMethodModel;
		var controller:CornusMethodController;
		var objStage:Object;
		var fullmovie:MovieClip;
		var lan:String;
		var positionX;
		var positionY;
		var loadFont;
		var FontName;
		var format:TextFormat=new TextFormat;

		var LightOn:Boolean;
		var initWeightRings2X;
		var initWeightRings1X;
		var initDistance=10;
		var initMass=300;
		var microHPosVal;
		var microVPosVal;
		var initReading=2.6;
		var currentDiffH;
		var currentDiffV;
		var initHscaleX;
		var dragFlag1:Boolean;
		var dragFlag2:Boolean;
		var initVscaleX;
		var initVscaleY;

		var mbMc_view:CornusMethodViewMovieclip=new CornusMethodViewMovieclip  ;
		var LightSource_txt:TextField=new TextField  ;
		var WeightRings_txt:TextField=new TextField  ;
		var Microscope_txt:TextField=new TextField  ;
		var perpexBar_txt:TextField=new TextField  ;
		var LightSource_cbx:ComboBox=new ComboBox  ;
		var LightSource_cbxLabel:Array;
		var RadiusLens_sldr:Slider;
		var BreadthGlass_sldr:Slider;
		var ThicknessGlass_sldr:Slider;
		var Mass_sldr:Slider;
		var Distance_sldr:Slider;
		var MicroVpostion_sldr:Slider;
		var MicroHpostion_sldr:Slider;
		var FineZoomHscale_sldr:Slider;
		var FineZoomVsacle_sldr:Slider;
		var LightOn_btn:Button=new Button  ;
		var Reset_btn:Button=new Button  ;
		var ellipse:MovieClip;
		var Ellipse:MovieClip=new MovieClip  ;
		public function CornusMethodView(model:CornusMethodModel,controller:CornusMethodController,holder:Object,positionX:Number,positionY:Number,loadFont:Object,FontName:String,fullmovie:MovieClip,lan:String,Embedded_Font_Format:TextFormat) {
			this.model=model;
			this.controller=controller;
			this.objStage=holder;
			this.loadFont=loadFont;
			this.FontName=FontName;
			this.fullmovie=fullmovie;
			this.lan=lan;
			this.positionX=positionX;
			this.positionY=positionY;
			format=Embedded_Font_Format;
			Locale.addXMLPath(lan,"CornusMethod"+lan+".xml");
			Locale.setLoadCallback(onLoaded);
			Locale.loadLanguageXML(lan);

		}
		public function update(e:Event):void {

		}
		function embedFontsToSlider(Mc:Slider) {
			Mc.getChildAt(4).setStyle("textFormat",format);
			Mc.getChildAt(4).setStyle("embedFonts",true);
			Mc.getChildAt(5).defaultTextFormat=format;
			Mc.getChildAt(5).embedFonts=true;
			Mc.getChildAt(2).text="";
		}
		function drawEllipse() {
			var d1;
			var d2;
			Ellipse.graphics.clear();
			for (var i=0; i<10; i++) {
				d1=model.findDiameterWidth(i+1)*1400;
				d2=model.findDiameterHeight(i+1)*1400;
				Ellipse.graphics.lineStyle(3,0xF7C004);
				Ellipse.graphics.drawEllipse(0+d1/2*-1,0+d2/2*-1,d1,d2);
			}

		}
		function Reset(e:MouseEvent) {


			Ellipse.x=0;
			Ellipse.y=0;
			LightOn=false;
			LightOn_btn.label=Locale.loadString("IDS_LIGHTON");

			model.setRadiusLens(2);
			model.setBreadth(0.02);
			model.setThickness(0.003);
			model.setMass(initMass/1000);
			model.setDistance(initDistance/100);
			
			Mass_sldr.value=initMass;
			Mass_sldr.getChildAt(4).text=Mass_sldr.value+" gm";
			
			Distance_sldr.value=initDistance;
			Distance_sldr.getChildAt(4).text=Distance_sldr.value+" cm";
			Distance_sldr.getChildAt(4).x=80;
			ThicknessGlass_sldr.getChildAt(4).text=ThicknessGlass_sldr.value+"mm";
			ThicknessGlass_sldr.getChildAt(4).x=80;
			BreadthGlass_sldr.getChildAt(4).text=BreadthGlass_sldr.value+"cm";
			BreadthGlass_sldr.getChildAt(4).x=80;
			MicroHpostion_sldr.value=2.6;
			model.setHPosition(MicroHpostion_sldr.value);
			////////////////////////////////////////////////
			MicroHpostion_sldr.getChildAt(4).text="";
			MicroHpostion_sldr.getChildAt(3).text="";
			MicroHpostion_sldr.getChildAt(1).text="";
			////////////////////////////////////////////////
			MicroVpostion_sldr.value=2.6;
			model.setVPosition(MicroVpostion_sldr.value);
			////////////////////////////////////////////////
			MicroVpostion_sldr.getChildAt(4).text="";
			MicroVpostion_sldr.getChildAt(3).text="";
			MicroVpostion_sldr.getChildAt(1).text="";
			////////////////////////////////////////////////
			FineZoomHscale_sldr.value=0;
			FineZoomVsacle_sldr.value=0;
			objStage.Exp_Content.totalMc.sodiumLight.visible=false;
			Ellipse.visible=false;
			addWeightRings(Mass_sldr.value);
            ////////
			
			FineZoomVsacle_sldr.getChildAt(4).text="";
			FineZoomVsacle_sldr.getChildAt(3).text="";
			FineZoomVsacle_sldr.getChildAt(1).text="";
			FineZoomVsacle_sldr.getChildAt(2).text="";
			
			objStage.Exp_Content.totalMc.WeightRings2.x=initWeightRings2X;
			objStage.Exp_Content.totalMc.WeightRings1.x=initWeightRings1X;
			trace("11111111");
			objStage.Exp_Content.totalMc.horizontalScale.Hscale.scaleX=1;
			objStage.Exp_Content.totalMc.horizontalScale.Hscale.scaleY=1;
			objStage.Exp_Content.totalMc.horizontalScale.Hscale.x=0.8;
			//objStage.Exp_Content.totalMc.horizontalScale.Hscale.y=1.65;
			objStage.Exp_Content.totalMc.horizontalScale.Hscale.y=-2;
			
			
			objStage.Exp_Content.totalMc.VerticalScale.Vscale.x=initVscaleX;
			objStage.Exp_Content.totalMc.VerticalScale.Vscale.y=initVscaleY;
			trace("objStage.Exp_Content.totalMc.horizontalScale.Hscale.x ----  "+objStage.Exp_Content.totalMc.horizontalScale.Hscale.x+" objStage.Exp_Content.totalMc.horizontalScale.Hscale.y ---- "+objStage.Exp_Content.totalMc.horizontalScale.Hscale.y);
			objStage.Exp_Content.totalMc.VerticalScale.Vscale.scaleX=0.771
			objStage.Exp_Content.totalMc.VerticalScale.Vscale.scaleY=0.771
			
		    //objStage.Exp_Content.totalMc.VerticalScale.Vscale.x=-1.35;
			//objStage.Exp_Content.totalMc.VerticalScale.Vscale.y= -1.95;
			//trace("objStage.Exp_Content.totalMc.VerticalScale.Vscale.x ----  "+objStage.Exp_Content.totalMc.VerticalScale.Vscale.x+" objStage.Exp_Content.totalMc.VerticalScale.Vscale.y ---- "+objStage.Exp_Content.totalMc.VerticalScale.Vscale.y);
			objStage.Exp_Content.totalMc.vernierScale.x=46.8;
			objStage.Exp_Content.totalMc.microVertical_part.x=45;
			objStage.Exp_Content.totalMc.mc_lens.x=106.05
			objStage.Exp_Content.totalMc.microVertical_part.y=-44.15;
			
			//FineZoomHscale_sldr.visible=false;
		}
		function StartDrag(e:MouseEvent) {
			if (e.target.name=="hitMc") {
				dragFlag1=true;
				dragFlag2=false;
				objStage.Exp_Content.totalMc.horizontalScale.Hscale.startDrag();
			} else if (e.target.name=="hitMc1") {
				dragFlag1=false;
				dragFlag2=true;
				objStage.Exp_Content.totalMc.VerticalScale.Vscale.startDrag();
				}
		}
		
		function StopDrag(e:MouseEvent) {
			if (dragFlag1) {
				dragFlag1=false;
				objStage.Exp_Content.totalMc.horizontalScale.Hscale.stopDrag();
			} else if (dragFlag2) {
				dragFlag2=false;
				objStage.Exp_Content.totalMc.VerticalScale.Vscale.stopDrag();
			}
			//trace("sssssss:"+objStage.Exp_Content.totalMc.horizontalScale.Hscale.MainScale.x)
			//trace("sssssss:"+objStage.Exp_Content.totalMc.horizontalScale.Hscale.vernierScale.x)
		}
		function RollOver(e:MouseEvent) {
			FineZoomHscale_sldr.visible=true;
		}
		function RollOut(e:MouseEvent) {
			FineZoomHscale_sldr.visible=false;
		}
		function SliderRollOver(e:MouseEvent) {
			e.target.visible=true;
		}
		function SliderRollOut(e:MouseEvent) {
			e.target.visible=false;
		}
		function RadiusSlider_FN(e:SliderEvent) {
			controller.RadiusSlider_FN(e);
			drawEllipse();
			e.target.getChildAt(4).text=e.target.value+" cm";
		}
		function BreadthSlider_FN(e:SliderEvent) {
			controller.BreadthSlider_FN(e);
			drawEllipse();
			e.target.getChildAt(4).text=e.target.value+" cm";
		}
		function ThicknessSlider_FN(e:SliderEvent) {
			controller.ThicknessSlider_FN(e);
			drawEllipse();
			e.target.getChildAt(4).text=e.target.value+" mm";
		}
		function MassSlider_FN(e:SliderEvent) {
			controller.MassSlider_FN(e);
			drawEllipse();
			e.target.getChildAt(4).text=e.target.value+" gm";
			addWeightRings(e.target.value);
		}
		function VPositionSlider_FN(e:SliderEvent) {
			controller.VPositionSlider_FN(e);
			//trace("VPositionSlider_FN"+e.target.value)
			//objStage.Exp_Content.totalMc.vernierScale.x=13;
			/*if(e.target.value<=.1){
				trace("inside")
				objStage.Exp_Content.totalMc.VerticalScale.x=13;
			}*/
			/****************************/
			mOveElpsMicroScaleV();
			/****************************/
		}
		function HPositionSlider_FN(e:SliderEvent) {
			controller.HPositionSlider_FN(e);
			trace("HPositionSlider_FN"+e.target.value)
			/****************************/
			mOveElpsMicroScaleH();
			
			/****************************/

		}
		function addWeightRings(n) {
			n=n/100;
			for (var j=2; j<=10; j++) {
				objStage.Exp_Content.totalMc.WeightRings1["weightRing"+j].visible=false;
				objStage.Exp_Content.totalMc.WeightRings2["weightRing"+j].visible=false;
			}
			if (n<=10) {
				for (var i=1; i<=n; i++) {
					objStage.Exp_Content.totalMc.WeightRings1["weightRing"+i].visible=true;
					objStage.Exp_Content.totalMc.WeightRings2["weightRing"+i].visible=true;

				}
			}

		}
		function DistanceSlider_FN(e:SliderEvent) {
			controller.DistanceSlider_FN(e);
			drawEllipse();
			e.target.getChildAt(4).text=e.target.value+" cm";
			objStage.Exp_Content.totalMc.WeightRings2.x=initWeightRings2X+((e.target.value-10)*1.5);
            objStage.Exp_Content.totalMc.WeightRings1.x=initWeightRings1X-((e.target.value-10)*1.5);
		}
		function FineZoom_FN(e:SliderEvent) {
			controller.FineZoom_FN(e);
			
			if (e.target.name=="FineZoomHscale_sldr") {
				objStage.Exp_Content.totalMc.horizontalScale.Hscale.scaleX=1+model.getHZoom()/85;
				objStage.Exp_Content.totalMc.horizontalScale.Hscale.scaleY=1+model.getHZoom()/85;
			} else if (e.target.name=="FineZoomVsacle_sldr") {
				
				objStage.Exp_Content.totalMc.VerticalScale.Vscale.scaleX=0.771+model.getVZoom()/85;
				objStage.Exp_Content.totalMc.VerticalScale.Vscale.scaleY=0.771+model.getVZoom()/85;
			}

		}
		function SwitchLight(e:MouseEvent) {
			LightOn=LightOn?false:true;
			if (LightOn) {
				e.target.label=Locale.loadString("IDS_LIGHTOFF");
				Ellipse.visible=true;
				objStage.Exp_Content.totalMc.sodiumLight.visible=true;

			} else {
				e.target.label=Locale.loadString("IDS_LIGHTON");
				Ellipse.visible=false;
				objStage.Exp_Content.totalMc.sodiumLight.visible=false;
			}
		}
		function fineHorizAdjustUp(e:MouseEvent) {
			controller.fineHorizAdjustUp(e);
			mOveElpsMicroScaleH();
			}
		function fineHorizAdjustDown(e:MouseEvent) {
			controller.fineHorizAdjustDown(e);
			mOveElpsMicroScaleH();
			}
		
		function mOveElpsMicroScaleH() {
			microHPosVal=model.getHPosition();
			currentDiffH=microHPosVal-initReading;
			Ellipse.x=0-currentDiffH*450;
			
			objStage.Exp_Content.totalMc.horizontalScale.Hscale.MainScale.x=-36.65-currentDiffH*5.5;
			objStage.Exp_Content.totalMc.vernierScale.x=52+currentDiffH*3;
			objStage.Exp_Content.totalMc.microVertical_part.x=52+currentDiffH*3;
			objStage.Exp_Content.totalMc.mc_lens.x=106.1+currentDiffH*3;
			objStage.Exp_Content.totalMc.dot1.x=-19.1+currentDiffH*3;
			objStage.Exp_Content.totalMc.vertical_mc.x=4.5+currentDiffH*3.2
			//trace("objStage.Exp_Content.totalMc.vernierScale.x:"+objStage.Exp_Content.totalMc.vernierScale.x)
	     }
		 
		function fineVertiAdjustUp(e:MouseEvent) {
			controller.fineVertiAdjustUp(e);
			mOveElpsMicroScaleV();
			}
		function fineVertiAdjustDown(e:MouseEvent) {
			controller.fineVertiAdjustDown(e);
			mOveElpsMicroScaleV();
			}
		function mOveElpsMicroScaleV() {
			microVPosVal=model.getVPosition();
			currentDiffV=microVPosVal-initReading;
			Ellipse.y=0-currentDiffV*450;
			objStage.Exp_Content.totalMc.VerticalScale.Vscale.MainScale.y=25.6-currentDiffV*5.5;
			objStage.Exp_Content.totalMc.microVertical_part.y=-48-currentDiffV;
			//objStage.Exp_Content.totalMc.vernierScale.x=27+currentDiffV-10;
			}
		function onLoaded(success:Boolean):void {

			initWeightRings2X=objStage.Exp_Content.totalMc.WeightRings2.x;
			initWeightRings1X=objStage.Exp_Content.totalMc.WeightRings1.x;
			objStage.Exp_Content.totalMc.hitMc.buttonMode=true;
			objStage.Exp_Content.totalMc.hitMc1.buttonMode=true;
			
			  initVscaleX=1.8;
			  initVscaleY=-0.1;
			 //initVscaleX=123.65;
			 //initVscaleY=-2.9; 
			
			
			//objStage.Exp_Content.totalMc.hitMc.

			//initHscaleX=objStage.Exp_Content.totalMc.horizontalScale.scaleX;

			LightSource_txt=mbMc_view.createTextField(objStage.Menu_Content1,Locale.loadString("IDS_LIGHT_SOURCE"),false,positionX-7,positionY-50,165,format);

			LightSource_cbxLabel=new Array(Locale.loadString("IDS_SODIUM"));
			LightSource_cbx=mbMc_view.createComboBox(LightSource_cbxLabel,"LightCombobox",positionX,LightSource_txt.y+20,155);
			objStage.Menu_Content1.addChild(LightSource_cbx);

			RadiusLens_sldr=new Slider  ;
			RadiusLens_sldr=fullmovie.makeSlider(LightSource_cbx.x-2,LightSource_cbx.y+45,200,400,155,50,Locale.loadString("IDS_RADIUS_LENS"),10,0);
			objStage.Menu_Content1.addChild(RadiusLens_sldr);
			RadiusLens_sldr.name="RadiusLens_sldr";
            //embedFontsToSlider(RadiusLens_sldr);
			RadiusLens_sldr.getChildAt(2).visible=false;
			RadiusLens_sldr.getChildAt(5).x=-6;
			RadiusLens_sldr.getChildAt(4).x=85;
			RadiusLens_sldr.getChildAt(4).text=RadiusLens_sldr.value+" cm";
            RadiusLens_sldr.addEventListener(SliderEvent.CHANGE,RadiusSlider_FN);
 			perpexBar_txt=mbMc_view.createTextField(objStage.Menu_Content1,Locale.loadString("IDS_PERPEXBAR"),false,positionX-7,RadiusLens_sldr.y+20,165,format);
			
			BreadthGlass_sldr=new Slider  ;
			BreadthGlass_sldr=fullmovie.makeSlider(LightSource_cbx.x-2,perpexBar_txt.y+40,2,5,155,50,Locale.loadString("IDS_BREADTH"),0.1,0);
			objStage.Menu_Content1.addChild(BreadthGlass_sldr);
			BreadthGlass_sldr.name="BreadthGlass_sldr";
			BreadthGlass_sldr.getChildAt(5).x=-4;
			//trace(BreadthGlass_sldr.getChildAt(4).x)
			//BreadthGlass_sldr.getChildAt(4).x=180;
			BreadthGlass_sldr.getChildAt(2).visible=false;
			BreadthGlass_sldr.getChildAt(4).text=BreadthGlass_sldr.value+"cm";

			BreadthGlass_sldr.addEventListener(SliderEvent.CHANGE,BreadthSlider_FN);

			ThicknessGlass_sldr=new Slider  ;
			ThicknessGlass_sldr=fullmovie.makeSlider(LightSource_cbx.x-2,BreadthGlass_sldr.y+40,3,6,155,50,Locale.loadString("IDS_THICKNESS"),0.1,0);
			objStage.Menu_Content1.addChild(ThicknessGlass_sldr);
			ThicknessGlass_sldr.name="ThicknessGlass_sldr";
			ThicknessGlass_sldr.getChildAt(2).visible=false;
			ThicknessGlass_sldr.getChildAt(5).x=-4;
			ThicknessGlass_sldr.getChildAt(4).text=ThicknessGlass_sldr.value+"mm";

			ThicknessGlass_sldr.addEventListener(SliderEvent.CHANGE,ThicknessSlider_FN);

			WeightRings_txt=mbMc_view.createTextField(objStage.Menu_Content1,Locale.loadString("IDS_WEIGHTRINGS"),false,positionX-5,ThicknessGlass_sldr.y+20,165,format);
           
			Mass_sldr=new Slider  ;
			Mass_sldr=fullmovie.makeSlider(LightSource_cbx.x-2,WeightRings_txt.y+40,100,1000,150,50,Locale.loadString("IDS_MASS"),100,0);
			objStage.Menu_Content1.addChild(Mass_sldr);
			Mass_sldr.name="Mass_sldr";
			Mass_sldr.getChildAt(5).x=-1;
			Mass_sldr.getChildAt(4).x=80;
			trace("Mass_sldr.getChildAt(1).x"+Mass_sldr.getChildAt(1).x)
			Mass_sldr.getChildAt(2).visible=false;
			Mass_sldr.getChildAt(4).text=Mass_sldr.value+" gm";

			Mass_sldr.addEventListener(SliderEvent.CHANGE,MassSlider_FN);
			Distance_sldr=new Slider  ;
			Distance_sldr=fullmovie.makeSlider(LightSource_cbx.x-2,Mass_sldr.y+40,initDistance,15,155,50,Locale.loadString("IDS_FROM_KNIFEEDGE"),1,0);
			objStage.Menu_Content1.addChild(Distance_sldr);
			Distance_sldr.name="Distance_sldr";
			Distance_sldr.getChildAt(2).visible=false;
			Distance_sldr.getChildAt(5).x=-1;
			//Distance_sldr.getChildAt(4).x
			Distance_sldr.getChildAt(4).text=Distance_sldr.value+" cm";
			

			Distance_sldr.addEventListener(SliderEvent.CHANGE,DistanceSlider_FN);

			LightOn_btn=mbMc_view.createButton(Locale.loadString("IDS_LIGHTON"),Distance_sldr.x+15,Distance_sldr.y+25,100,true);
			objStage.Menu_Content1.addChild(LightOn_btn);
			LightOn_btn.addEventListener(MouseEvent.MOUSE_DOWN,SwitchLight);

			Microscope_txt=mbMc_view.createTextField(objStage.Menu_Content1,Locale.loadString("IDS_MICROSCOPE"),false,positionX-4,LightOn_btn.y+35,165,format);

			MicroVpostion_sldr=new Slider  ;
			MicroVpostion_sldr=fullmovie.makeSlider(LightSource_cbx.x-2,Microscope_txt.y+37,0,15,155,50,Locale.loadString("IDS_VERTICAL"),.1,0);
			objStage.Menu_Content1.addChild(MicroVpostion_sldr);
			MicroVpostion_sldr.name="MicroVpostion_sldr";
			MicroVpostion_sldr.getChildAt(2).visible=false;
			MicroVpostion_sldr.getChildAt(5).x=-1;
            MicroVpostion_sldr.addEventListener(SliderEvent.CHANGE,VPositionSlider_FN);
			
			MicroHpostion_sldr=new Slider  ;
			MicroHpostion_sldr=fullmovie.makeSlider(LightSource_cbx.x-2,MicroVpostion_sldr.y+45,0,15,155,50,Locale.loadString("IDS_HORIZONTAL"),.1,0);
			objStage.Menu_Content1.addChild(MicroHpostion_sldr);
			MicroHpostion_sldr.name="MicroHpostion_sldr";
			MicroHpostion_sldr.getChildAt(2).visible=false;
			MicroHpostion_sldr.getChildAt(5).x=-1;
            MicroHpostion_sldr.addEventListener(SliderEvent.CHANGE,HPositionSlider_FN);
			
			Reset_btn=mbMc_view.createButton(Locale.loadString("IDS_RESET"),MicroHpostion_sldr.x+15,MicroHpostion_sldr.y+20,100,true);
			objStage.Menu_Content1.addChild(Reset_btn);
			Reset_btn.addEventListener(MouseEvent.MOUSE_DOWN,Reset);

			FineZoomHscale_sldr=new Slider  ;
			FineZoomHscale_sldr=fullmovie.makeSlider(40,455,0,5,160,50,"",.1,0);
			FineZoomHscale_sldr.name="FineZoomHscale_sldr";

			objStage.Exp_Content.addChild(FineZoomHscale_sldr);
			//FineZoomHscale_sldr.visible=false;
			FineZoomHscale_sldr.getChildAt(2).visible=FineZoomHscale_sldr.getChildAt(3).visible=FineZoomHscale_sldr.getChildAt(4).visible=FineZoomHscale_sldr.getChildAt(1).visible=false;
			FineZoomHscale_sldr.addEventListener(SliderEvent.CHANGE,FineZoom_FN);

			FineZoomVsacle_sldr=new Slider  ;
			FineZoomVsacle_sldr=fullmovie.makeSlider(43,315,0,5,150,50,"",.1,0);
			objStage.Exp_Content.addChild(FineZoomVsacle_sldr);
			FineZoomVsacle_sldr.name="FineZoomVsacle_sldr";
			FineZoomVsacle_sldr.getChildAt(2).visible=FineZoomVsacle_sldr.getChildAt(3).visible=FineZoomVsacle_sldr.getChildAt(4).visible=FineZoomVsacle_sldr.getChildAt(1).visible=false;
			//FineZoomVsacle_sldr.rotation=270;
			FineZoomVsacle_sldr.addEventListener(SliderEvent.CHANGE,FineZoom_FN);

			objStage.Exp_Content.totalMc.circleBg.addChild(Ellipse);
			//trace("ddd:"+objStage.Exp_Content.totalMc.horizontalScale.Hscale.MainScale.x);//objStage.Exp_Content.totalMc.VerticalScale.Vscale.scaleY);
			//trace("gggggg"+objStage.Exp_Content.totalMc.microVertical_part.vernierScale.x)
			Reset(null);
			drawEllipse();
			Ellipse.mask=objStage.Exp_Content.totalMc.maskClip;
			objStage.Exp_Content.totalMc.lensInMicro.parent.setChildIndex(objStage.Exp_Content.totalMc.lensInMicro,objStage.Exp_Content.totalMc.lensInMicro.parent.numChildren-1);

			objStage.Exp_Content.totalMc.fineAdjusBtn.fineUp.addEventListener(MouseEvent.MOUSE_DOWN,fineHorizAdjustUp);
			objStage.Exp_Content.totalMc.fineAdjusBtn.fineDown.addEventListener(MouseEvent.MOUSE_DOWN,fineHorizAdjustDown);
			objStage.Exp_Content.totalMc.microVertical_part.fineUp1.addEventListener(MouseEvent.MOUSE_DOWN,fineVertiAdjustUp);
			objStage.Exp_Content.totalMc.microVertical_part.finedown1.addEventListener(MouseEvent.MOUSE_DOWN,fineVertiAdjustDown);
			objStage.Exp_Content.totalMc.hitMc.addEventListener(MouseEvent.MOUSE_DOWN,StartDrag);
			objStage.Exp_Content.totalMc.hitMc1.addEventListener(MouseEvent.MOUSE_DOWN,StartDrag);
			//objStage.Exp_Content.totalMc.hitMc.addEventListener(MouseEvent.MOUSE_OVER,RollOver);
			//objStage.Exp_Content.totalMc.hitMc.addEventListener(MouseEvent.MOUSE_OUT,RollOut);
			//FineZoomHscale_sldr.addEventListener(MouseEvent.MOUSE_OVER,SliderRollOver)
			//FineZoomHscale_sldr.addEventListener(MouseEvent.MOUSE_OUT,SliderRollOut)
			objStage.addEventListener(MouseEvent.MOUSE_UP,StopDrag);

		}
	}
}