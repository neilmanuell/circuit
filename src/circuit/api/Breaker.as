package circuit.api
{
import circuit.signals.BreakerStateChangedSignal;

public interface Breaker
{
    function get onStateChanged():BreakerStateChangedSignal
    function get isClosed():Boolean
    function open():void
    function close():void

}
}
