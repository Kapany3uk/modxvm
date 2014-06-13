package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.IStrCaseProperties;
   import net.wg.infrastructure.interfaces.IImageUrlProperties;


   public interface IUtilsManagerMeta extends IEventDispatcher
   {
          
      function getNationNamesS() : Array;

      function getNationIndicesS() : Object;

      function getGUINationsS() : Array;

      function changeStringCasingS(param1:String, param2:Boolean, param3:IStrCaseProperties) : String;

      function getAbsoluteUrlS(param1:String) : String;

      function getHtmlIconTextS(param1:IImageUrlProperties) : String;
   }

}