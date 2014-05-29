package net.wg.gui.lobby.battleResults
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.SortableHeaderButtonBar;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.events.FinalStatisticEvent;
   import scaleform.clik.events.ListEvent;
   import net.wg.gui.events.ListEventEx;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.components.advanced.InteractiveSortingButton;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.data.constants.SortingInfo;
   import net.wg.gui.components.advanced.SortingButtonInfo;
   import flash.display.InteractiveObject;


   public class TeamStats extends UIComponent implements IViewStackContent
   {
          
      public function TeamStats() {
         this.iconTypeToKey =
            {
               "squad":
                  {
                     "key":"prebattleID",
                     "isNumeric":true,
                     "index":0
                  }
               ,
               "player":
                  {
                     "key":"playerName",
                     "isNumeric":false,
                     "index":1
                  }
               ,
               "tank":
                  {
                     "key":"vehicleSort",
                     "isNumeric":true,
                     "index":2
                  }
               ,
               "damage":
                  {
                     "key":"damageDealt",
                     "isNumeric":true,
                     "index":3
                  }
               ,
               "frag":
                  {
                     "key":"realKills",
                     "isNumeric":true,
                     "index":4
                  }
               ,
               "xp":
                  {
                     "key":["xpSort","damageDealt","vehicleId"],
                     "isNumeric":true,
                     "index":5
                  }
               ,
               "medal":
                  {
                     "key":"medalsCount",
                     "isNumeric":true,
                     "index":6
                  }
               ,
               "resourceCount":
                  {
                     "key":"resourceCount",
                     "isNumeric":true,
                     "index":6
                  }
               
            }
         ;
         super();
      }

      private static const SQUAD:String = "squad";

      private static const PLAYER:String = "player";

      private static const TANK:String = "tank";

      private static const DAMAGE:String = "damage";

      private static const FRAG:String = "frag";

      private static const XP:String = "xp";

      private static const MEDAL:String = "medal";

      private static const FORT_RESOURCE:String = "resourceCount";

      private static const CLAN_TEAM_ALLIES:String = "clanTeamAllies";

      private static const CLAN_TEAM_ENEMIES:String = "clanTeamEnemies";

      public var team1List:TeamStatsList;

      public var team2List:TeamStatsList;

      public var team1Stats:TeamMemberStatsView;

      public var team2Stats:TeamMemberStatsView;

      public var ownTitle:TextField;

      public var enemyTitle:TextField;

      private var _changeIndexOnFocus:Boolean = true;

      public var header1:SortableHeaderButtonBar;

      public var header2:SortableHeaderButtonBar;

      public var teamResourceTotal:TextField;

      private var _focusCandidate:Object;

      private var _bonusType:int = 1;

      private var iconTypeToKey:Object;

      override protected function configUI() : void {
         var _loc1_:Object = null;
         var _loc2_:String = null;
         super.configUI();
         _loc1_ = this.myParent.data;
         this._bonusType = _loc1_.common.bonusType;
         this.header1.dataProvider = this.header2.dataProvider = this.getHeadersProvider();
         this.header1.tabEnabled = false;
         this.header1.focusable = false;
         this.header1.validateNow();
         this.header2.validateNow();
         if(this._bonusType == 10)
         {
            this.ownTitle.htmlText = App.utils.locale.makeString(BATTLE_RESULTS.TEAM_STATS_OWNTEAM) + " " + _loc1_.common.clans.allies.clanAbbrev;
            this.enemyTitle.htmlText = App.utils.locale.makeString(BATTLE_RESULTS.TEAM_STATS_ENEMYTEAM) + " " + _loc1_.common.clans.enemies.clanAbbrev;
            this.myParent.requestClanEmblem(CLAN_TEAM_ALLIES,_loc1_.common.clans.allies.clanDBID,this.onEmblemLoaded);
            this.myParent.requestClanEmblem(CLAN_TEAM_ENEMIES,_loc1_.common.clans.enemies.clanDBID,this.onEmblemLoaded);
            this.teamResourceTotal.visible = true;
            this.teamResourceTotal.htmlText = _loc1_.common.totalFortResourceStr;
         }
         else
         {
            this.ownTitle.text = BATTLE_RESULTS.TEAM_STATS_OWNTEAM;
            this.enemyTitle.text = BATTLE_RESULTS.TEAM_STATS_ENEMYTEAM;
            this.teamResourceTotal.visible = false;
         }
         this.header2.tabEnabled = false;
         this.header2.focusable = false;
         this.team1Stats.list = this.team1List;
         this.team2Stats.list = this.team2List;
         this.team2Stats.visible = this.team1Stats.visible = false;
         this.team1List.mouseEnabled = this.team2List.mouseEnabled = false;
         this.header1.addEventListener(ButtonEvent.CLICK,this.onHeaderClick);
         this.header2.addEventListener(ButtonEvent.CLICK,this.onHeaderClick);
         this.myParent.addEventListener(FinalStatisticEvent.HIDE_STATS_VIEW,this.hideStatsView);
         this.team1List.addEventListener(ListEvent.INDEX_CHANGE,this.onIndexChange);
         this.team2List.addEventListener(ListEvent.INDEX_CHANGE,this.onIndexChange);
         this.team1List.addEventListener(ListEventEx.ITEM_CLICK,this.onItemSelect);
         this.team2List.addEventListener(ListEventEx.ITEM_CLICK,this.onItemSelect);
         this.team1List.dataProvider = new DataProvider(_loc1_.team1);
         this.team2List.dataProvider = new DataProvider(_loc1_.team2);
         _loc2_ = _loc1_.common.iconType;
         var _loc3_:String = _loc1_.common.sortDirection;
         this.header1.selectedIndex = this.header2.selectedIndex = this.iconTypeToKey[_loc2_].index;
         var _loc4_:InteractiveSortingButton = InteractiveSortingButton(this.header1.getButtonAt(this.iconTypeToKey[_loc2_].index));
         var _loc5_:InteractiveSortingButton = InteractiveSortingButton(this.header2.getButtonAt(this.iconTypeToKey[_loc2_].index));
         _loc4_.sortDirection = _loc5_.sortDirection = _loc3_;
         this.applySort(_loc2_,_loc3_);
      }

      public function onEmblemLoaded(param1:String, param2:String) : void {
         var _loc3_:Object = this.myParent.data;
         if(param1 == CLAN_TEAM_ALLIES)
         {
            this.ownTitle.htmlText = App.utils.locale.makeString(BATTLE_RESULTS.TEAM_STATS_OWNTEAM) + " " + param2 + " " + _loc3_.common.clans.allies.clanAbbrev;
         }
         else
         {
            if(param1 == CLAN_TEAM_ENEMIES)
            {
               this.enemyTitle.htmlText = App.utils.locale.makeString(BATTLE_RESULTS.TEAM_STATS_ENEMYTEAM) + " " + param2 + " " + _loc3_.common.clans.enemies.clanAbbrev;
            }
         }
      }

      private function hideStatsView(param1:FinalStatisticEvent) : void {
         this.team1List.selectedIndex = -1;
         this.team2List.selectedIndex = -1;
      }

      private function onItemSelect(param1:ListEvent) : void {
         if(param1.target.selectedIndex == param1.index)
         {
            param1.target.selectedIndex = -1;
         }
         this._focusCandidate = param1.target;
         dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
      }

      private function onIndexChange(param1:ListEvent) : void {
         var _loc4_:ScrollingListEx = null;
         if(param1.target.selectedIndex != -1)
         {
            _loc4_ = param1.target == this.team1List?this.team2List:this.team1List;
            _loc4_.selectedIndex = -1;
            _loc4_.validateNow();
         }
         this.team1Stats.data = this.team1List.dataProvider[this.team1List.selectedIndex];
         this.team2Stats.data = this.team2List.dataProvider[this.team2List.selectedIndex];
         this.team1Stats.visible = this.team1List.selectedIndex > -1 && (this.team1Stats.data);
         this.team2Stats.visible = this.team2List.selectedIndex > -1 && (this.team2Stats.data);
         var _loc2_:Boolean = this.team2List.selectedIndex == -1 || !this.team2Stats.visible;
         var _loc3_:Boolean = this.team1List.selectedIndex == -1 || !this.team1Stats.visible;
         this.team1List.tabEnabled = this.team1List.visible = this.header1.visible = _loc2_;
         this.team2List.tabEnabled = this.team2List.visible = this.header2.visible = _loc3_;
      }

      public function get myParent() : BattleResults {
         return BattleResults(parent.parent.parent);
      }

      private function onHeaderClick(param1:ButtonEvent) : void {
         var _loc2_:InteractiveSortingButton = null;
         if(param1.target  is  InteractiveSortingButton)
         {
            if(param1.currentTarget == this.header1)
            {
               this.header2.selectedIndex = this.header1.selectedIndex;
               _loc2_ = InteractiveSortingButton(this.header2.getButtonAt(this.header1.selectedIndex));
            }
            else
            {
               this.header1.selectedIndex = this.header2.selectedIndex;
               _loc2_ = InteractiveSortingButton(this.header1.getButtonAt(this.header2.selectedIndex));
            }
            _loc2_.sortDirection = InteractiveSortingButton(param1.target).sortDirection;
            this.applySort(_loc2_.id,_loc2_.sortDirection);
         }
      }

      private function applySort(param1:String, param2:String) : void {
         var _loc3_:Number = 0;
         if(this.iconTypeToKey[param1].isNumeric)
         {
            _loc3_ = _loc3_ | Array.NUMERIC;
         }
         else
         {
            _loc3_ = _loc3_ | Array.CASEINSENSITIVE;
         }
         if(param2 == SortingInfo.DESCENDING_SORT)
         {
            _loc3_ = _loc3_ | Array.DESCENDING;
         }
         var _loc4_:Array = DataProvider(this.team1List.dataProvider).slice();
         _loc4_.sortOn(this.iconTypeToKey[param1].key,_loc3_);
         this.team1List.selectedIndex = -1;
         this.team1List.dataProvider = new DataProvider(_loc4_);
         _loc4_ = DataProvider(this.team2List.dataProvider).slice();
         _loc4_.sortOn(this.iconTypeToKey[param1].key,_loc3_);
         this.team2List.selectedIndex = -1;
         this.team2List.dataProvider = new DataProvider(_loc4_);
         this.myParent.saveSortingS(param1,param2,this._bonusType);
      }

      override protected function onDispose() : void {
         this.header1.removeEventListener(ButtonEvent.CLICK,this.onHeaderClick);
         this.header1.dispose();
         this.header1 = null;
         this.header2.removeEventListener(ButtonEvent.CLICK,this.onHeaderClick);
         this.header2.dispose();
         this.header2 = null;
         this.team1List.removeEventListener(ListEvent.INDEX_CHANGE,this.onIndexChange);
         this.team1List.removeEventListener(ListEventEx.ITEM_CLICK,this.onItemSelect);
         this.team1List.dispose();
         this.team1List = null;
         this.team2List.removeEventListener(ListEvent.INDEX_CHANGE,this.onIndexChange);
         this.team2List.removeEventListener(ListEventEx.ITEM_CLICK,this.onItemSelect);
         this.team2List.dispose();
         this.team2List = null;
         this.myParent.removeEventListener(FinalStatisticEvent.HIDE_STATS_VIEW,this.hideStatsView);
         this.team1Stats.dispose();
         this.team1Stats = null;
         this.team2Stats.dispose();
         this.team2Stats = null;
         super.onDispose();
      }

      private function getHeadersProvider() : DataProvider {
         var _loc1_:* = "../maps/icons/buttons/tab_sort_button/ascendingSortArrow.png";
         var _loc2_:* = "../maps/icons/buttons/tab_sort_button/descendingSortArrow.png";
         var _loc3_:SortingButtonInfo = new SortingButtonInfo();
         _loc3_.iconId = SQUAD;
         _loc3_.iconSource = "../maps/icons/buttons/tab_sort_button/squad.png";
         _loc3_.ascendingIconSource = _loc1_;
         _loc3_.descendingIconSource = _loc2_;
         _loc3_.toolTip = BATTLE_RESULTS.TEAM_SQUADHEADER;
         _loc3_.buttonWidth = 30;
         _loc3_.buttonHeight = 30;
         _loc3_.enabled = true;
         _loc3_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
         var _loc4_:SortingButtonInfo = new SortingButtonInfo();
         _loc4_.iconId = PLAYER;
         _loc4_.iconSource = "../maps/icons/buttons/tab_sort_button/player.png";
         _loc4_.ascendingIconSource = _loc1_;
         _loc4_.descendingIconSource = _loc2_;
         _loc4_.toolTip = BATTLE_RESULTS.TEAM_PLAYERHEADER;
         _loc4_.buttonWidth = 120;
         _loc4_.buttonHeight = 30;
         _loc4_.enabled = true;
         _loc4_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
         var _loc5_:SortingButtonInfo = new SortingButtonInfo();
         _loc5_.iconId = TANK;
         _loc5_.iconSource = "../maps/icons/buttons/tab_sort_button/tank.png";
         _loc5_.ascendingIconSource = _loc1_;
         _loc5_.descendingIconSource = _loc2_;
         _loc5_.toolTip = BATTLE_RESULTS.TEAM_TANKHEADER;
         _loc5_.buttonWidth = 128;
         _loc5_.buttonHeight = 30;
         _loc5_.enabled = true;
         _loc5_.defaultSortDirection = SortingInfo.DESCENDING_SORT;
         var _loc6_:SortingButtonInfo = new SortingButtonInfo();
         _loc6_.iconId = DAMAGE;
         _loc6_.iconSource = "../maps/icons/buttons/tab_sort_button/damage.png";
         _loc6_.ascendingIconSource = _loc1_;
         _loc6_.descendingIconSource = _loc2_;
         _loc6_.toolTip = BATTLE_RESULTS.TEAM_DAMAGEHEADER;
         _loc6_.buttonWidth = 47;
         _loc6_.buttonHeight = 30;
         _loc6_.enabled = true;
         _loc6_.defaultSortDirection = SortingInfo.DESCENDING_SORT;
         var _loc7_:SortingButtonInfo = new SortingButtonInfo();
         _loc7_.iconId = FRAG;
         _loc7_.iconSource = "../maps/icons/buttons/tab_sort_button/frag.png";
         _loc7_.ascendingIconSource = _loc1_;
         _loc7_.descendingIconSource = _loc2_;
         _loc7_.toolTip = BATTLE_RESULTS.TEAM_FRAGHEADER;
         _loc7_.buttonWidth = 47;
         _loc7_.buttonHeight = 30;
         _loc7_.enabled = true;
         _loc7_.defaultSortDirection = SortingInfo.DESCENDING_SORT;
         var _loc8_:SortingButtonInfo = new SortingButtonInfo();
         _loc8_.iconId = XP;
         _loc8_.iconSource = "../maps/icons/buttons/tab_sort_button/star.png";
         _loc8_.ascendingIconSource = _loc1_;
         _loc8_.descendingIconSource = _loc2_;
         _loc8_.toolTip = BATTLE_RESULTS.TEAM_XPHEADER;
         _loc8_.buttonWidth = 61;
         _loc8_.buttonHeight = 30;
         _loc8_.enabled = true;
         _loc8_.defaultSortDirection = SortingInfo.DESCENDING_SORT;
         var _loc9_:SortingButtonInfo = new SortingButtonInfo();
         if(this._bonusType == 10)
         {
            _loc9_.iconId = FORT_RESOURCE;
            _loc9_.iconSource = "../maps/icons/buttons/tab_sort_button/nut.png";
            _loc9_.toolTip = BATTLE_RESULTS.TEAM_RESOURCEHEADER;
         }
         else
         {
            _loc9_.iconId = MEDAL;
            _loc9_.iconSource = "../maps/icons/buttons/tab_sort_button/medal.png";
            _loc9_.toolTip = BATTLE_RESULTS.TEAM_MEDALHEADER;
         }
         _loc9_.ascendingIconSource = _loc1_;
         _loc9_.descendingIconSource = _loc2_;
         _loc9_.buttonWidth = 62;
         _loc9_.buttonHeight = 30;
         _loc9_.enabled = true;
         _loc9_.defaultSortDirection = SortingInfo.DESCENDING_SORT;
         return new DataProvider([_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_]);
      }

      public function update(param1:Object) : void {
          
      }

      public function get changeIndexOnFocus() : Boolean {
         return this._changeIndexOnFocus;
      }

      public function set changeIndexOnFocus(param1:Boolean) : void {
         this._changeIndexOnFocus = param1;
      }

      public function getComponentForFocus() : InteractiveObject {
         return InteractiveObject(this._focusCandidate);
      }
   }

}