package circuit.api
{
import circuit.signals.BreakerStateChangedSignal;

public interface Edge
{
    function get onStateChanged():BreakerStateChangedSignal
    function get isClosed():Boolean
    function get id():String
    function open():void
    function close():void

}
}
