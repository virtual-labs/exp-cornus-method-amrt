package cornusMethod{
	
	public class CornusMethod{
		
		import cornusMethod.model.*;
		import cornusMethod.view.*;
		import cornusMethod.controller.*;
		import flash.display.MovieClip;	
		import flash.text.TextFormat;
					
		private var mb_model:CornusMethodModel;
		private var mb_view:CornusMethodView;
		private var mb_controller:CornusMethodController; 
				
		public function CornusMethod(holder:Object, positionX:Number, positionY:Number,loadFont:Object,FontName:String,fullmovie:MovieClip,lan:String,Embedded_Font_Format:TextFormat){
				
				// create the data model
				mb_model = new CornusMethodModel();
				// create the controller
				mb_controller = new CornusMethodController(mb_model);	
				// create the view   
				mb_view=new CornusMethodView(mb_model,mb_controller,holder,positionX,positionY,loadFont,FontName,fullmovie,lan,Embedded_Font_Format);
				
				
				// add mb_view as a listener to the mb_model
				//mb_model.addEventListener(CornusMethodModel.UPDATE, mb_view.update);
									
		}
		
	}
}