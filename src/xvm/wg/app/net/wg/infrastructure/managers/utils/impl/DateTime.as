package net.wg.infrastructure.managers.utils.impl
{
    import net.wg.utils.IDateTime;
    import net.wg.utils.IAssertable;
    import net.wg.data.constants.Time;
    import net.wg.data.daapi.DateParams;
    
    public class DateTime extends Object implements IDateTime
    {
        
        public function DateTime()
        {
            super();
        }
        
        private static function get asserter() : IAssertable
        {
            return App.utils.asserter;
        }
        
        public function now() : Date
        {
            return new Date();
        }
        
        public function cloneDate(param1:Date) : Date
        {
            return new Date(param1.time);
        }
        
        public function shiftDate(param1:Date, param2:int) : Date
        {
            return new Date(param1.time + param2);
        }
        
        public function timeDiff(param1:Date, param2:Date) : Number
        {
            return param1.time - param2.time;
        }
        
        public function isPast(param1:Date) : Boolean
        {
            return this.timeDiff(this.now(),param1) > 0;
        }
        
        public function isFuture(param1:Date) : Boolean
        {
            return this.timeDiff(this.now(),param1) < 0;
        }
        
        public function isSameDay(param1:Date, param2:Date) : Boolean
        {
            return param1.fullYear == param2.fullYear && param1.month == param2.month && param1.date == param2.date;
        }
        
        public function isSameMonth(param1:Date, param2:Date) : Boolean
        {
            return param1.fullYear == param2.fullYear && param1.month == param2.month;
        }
        
        public function isCurrentMonth(param1:Date) : Boolean
        {
            return this.isSameMonth(param1,this.now());
        }
        
        public function isToday(param1:Date) : Boolean
        {
            return this.isSameDay(param1,this.now());
        }
        
        public function getMonthDaysCount(param1:Date) : uint
        {
            var _loc2_:Date = this.cloneDate(param1);
            var _loc3_:uint = _loc2_.date = Time.MIN_MONTH_DAYS_COUNT;
            while(true)
            {
                _loc2_ = this.shiftDate(_loc2_,Time.DAY);
                if(this.isSameMonth(_loc2_,param1))
                {
                    _loc3_ = _loc3_ + 1;
                    continue;
                }
                break;
            }
            return _loc3_;
        }
        
        public function getMonthName(param1:int, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false) : String
        {
            if(!param2)
            {
                param1 = this.as3MonthNumToPyMonthNum(param1);
            }
            var _loc6_:String = param3?MENU.datetime_months_full(param1.toString()):MENU.datetime_months_short(param1.toString());
            var _loc7_:String = App.utils.locale.makeString(_loc6_);
            if(param4)
            {
                _loc7_ = App.utils.changeStringCasingS(_loc7_,true,null);
            }
            else if(param5)
            {
                _loc7_ = App.utils.changeStringCasingS(_loc7_,false,null);
            }
            
            return _loc7_;
        }
        
        public function getDayName(param1:int, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false) : String
        {
            if(!param2)
            {
                param1 = this.as3DayNumToPyDayNum(param1);
            }
            var _loc6_:String = param3?MENU.datetime_weekdays_full(param1.toString()):MENU.datetime_weekdays_short(param1.toString());
            var _loc7_:String = App.utils.locale.makeString(_loc6_);
            if(param4)
            {
                _loc7_ = App.utils.changeStringCasingS(_loc7_,true,null);
            }
            else if(param5)
            {
                _loc7_ = App.utils.changeStringCasingS(_loc7_,false,null);
            }
            
            return _loc7_;
        }
        
        public function toPyTimestamp(param1:Date) : Number
        {
            return param1.time / Time.SECOND ^ 0;
        }
        
        public function fromPyTimestamp(param1:Number) : Date
        {
            var _loc2_:Object = App.utils.getDateParamsS(param1);
            var _loc3_:DateParams = new DateParams(_loc2_);
            var _loc4_:Date = new Date(_loc3_.year,_loc3_.month,_loc3_.date,_loc3_.hour,_loc3_.minute,_loc3_.second,_loc3_.millisecond);
            return _loc4_;
        }
        
        public function getAS3FirstDayOfWeek() : int
        {
            var _loc1_:int = App.utils.getFirstDayOfWeekS();
            return this.pyDayNumToAS3DayNum(_loc1_);
        }
        
        public function pyDayNumToAS3DayNum(param1:int) : int
        {
            return param1 == 7?0:param1;
        }
        
        public function as3DayNumToPyDayNum(param1:int) : int
        {
            return param1 == 0?7:param1;
        }
        
        public function pyMonthNumToAS3MonthNum(param1:int) : int
        {
            return param1 - 1;
        }
        
        public function as3MonthNumToPyMonthNum(param1:int) : int
        {
            return param1 + 1;
        }
        
        public function convertToTwelveHourFormat(param1:int) : int
        {
            var _loc2_:* = "Invalid value of hour";
            asserter.assert(0 <= param1 && param1 <= Time.HOURS_IN_DAY,_loc2_);
            var _loc3_:* = Time.HOURS_IN_DAY >> 1;
            var _loc4_:int = param1 > _loc3_?param1 - _loc3_:param1;
            if(param1 == 0)
            {
                _loc4_ = _loc3_;
            }
            return _loc4_;
        }
    }
}
