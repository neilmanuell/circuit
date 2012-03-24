package circuit.api
{
import circuit.signals.CircuitStateChangedSignal;

public interface Circuit
{
    function get onStateChanged():CircuitStateChangedSignal
    function get isLive():Boolean
    function get id():String
}
}
