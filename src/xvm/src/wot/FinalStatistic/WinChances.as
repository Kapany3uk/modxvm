import wot.utils.Config;
import wot.utils.Chance;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Utils;

class wot.FinalStatistic.WinChances
{
    private var form_mc:MovieClip;

    public function WinChances(form_mc)
    {
        this.form_mc = form_mc;
        GlobalEventDispatcher.addEventListener("stat_loaded", this, onStatLoaded);
    }

    private function onStatLoaded()
    {
        GlobalEventDispatcher.removeEventListener("stat_loaded", this, onStatLoaded);

        if (Config.s_config.statisticForm.showChances)
            showWinChances();
    }

    private function showWinChances()
    {
        for (var i in _root.windowLayout)
        {
            if (!Utils.startsWith("battleResultsWnd", i))
                continue;
            var s_chanceField = _root.windowLayout[i].titleBtn.textField;
            form_mc.onEnterFrame = function()
            {
                if (s_chanceField.htmlText == undefined)
                    continue;
                delete this.onEnterFrame;
                s_chanceField.html = true;
                s_chanceField.htmlText += " | <font face='$TitleFont' size='18' color='#D8D8C8'>" +
                    Chance.GetChanceText(Config.s_config.statisticForm.showChancesExp) + "</font>";
            }
        }
    }
}
