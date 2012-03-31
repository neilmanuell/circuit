package circuit.base
{
import circuit.api.Node;

internal class CircuitPair
{
    private var _a:Node;
    private var _b:Node;

    public function CircuitPair( a:Node, b:Node ):void
    {
        _a = a;
        _b = b;
    }

    public function getOtherCircuit( thisCircuit:Node ):Node
    {
        if ( thisCircuit === _a )
            return _b;

        if ( thisCircuit === _b )
            return _a;

        return NULL_CIRCUIT;
    }

    public function has( circuit:Node ):Boolean
    {
        return( _a === circuit || _b == circuit);
    }
}
}
