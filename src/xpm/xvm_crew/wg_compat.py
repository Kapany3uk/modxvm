""" XVM (c) www.modxvm.com 2013-2015 """

from gui.shared.utils import decorators
from gui import SystemMessages

class _WGCompat():

    @decorators.process('crewReturning')
    def processReturnCrew(self, print_message = True):
        from gui.shared.gui_items.processors.tankman import TankmanReturn
        from CurrentVehicle import g_currentVehicle
        if not g_currentVehicle.isInHangar() or g_currentVehicle.isInBattle() or g_currentVehicle.isLocked() or g_currentVehicle.isCrewFull():
            return
        result = yield TankmanReturn(g_currentVehicle.item).request()
        if len(result.userMsg) and print_message:
            SystemMessages.g_instance.pushI18nMessage(result.userMsg, type=result.sysMsgType)

    @decorators.process('crewReturning')
    def processReturnCrewForVehicleSelectorPopup(self, vehicle):
        if not (vehicle.isCrewFull or vehicle.isInBattle or vehicle.isLocked):
            from gui.shared.gui_items.processors.tankman import TankmanReturn
            yield TankmanReturn(vehicle).request()

g_instance = _WGCompat()
