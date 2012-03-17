package circuit.base
{
import circuit.api.Circuit;

internal class CircuitPair
{
    private var _a:Circuit;
    private var _b:Circuit;

    public function CircuitPair( a:Circuit, b:Circuit ):void
    {
        _a = a;
        _b = b;
    }

    public function getOtherCircuit( thisCircuit:Circuit ):Circuit
    {
        if ( thisCircuit === _a )
            return _b;

        if ( thisCircuit === _b )
            return _a;

        return thisCircuit;
    }

    public function has( circuit:Circuit ):Boolean
    {
        return( _a === circuit || _b == circuit);
    }
}
}
