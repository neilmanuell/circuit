package circuit.api
{
import net.richardlord.ash.signals.Signal1;

public interface Supply
{
    function get id():String

    function get onStateChanged():Signal1

    function get isOn():Boolean;

    function switchOn():void;

    function switchOff():void;

}
}
