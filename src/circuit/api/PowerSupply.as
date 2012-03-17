package circuit.api
{
import circuit.signals.PowerSupplyChangedSignal;

public interface PowerSupply
{
    function get onStateChanged():PowerSupplyChangedSignal
    function get isOn():Boolean;
    function  switchOn():void;
    function switchOff():void;

}
}
