package circuit.api
{
import circuit.signals.PowerSupplyChangedSignal;

public interface Supply
{
    function get onStateChanged():PowerSupplyChangedSignal

    function get isOn():Boolean;

    function get id():String

    function switchOn():void;

    function switchOff():void;

}
}
