package circuit.api
{
import circuit.signals.CircuitStateChangedSignal;

public interface Node
{
    function get onStateChanged():CircuitStateChangedSignal
    function get isLive():Boolean
    function get id():String
}
}
