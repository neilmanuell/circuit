package circuit.signals
{
import circuit.api.Node;

import net.richardlord.ash.signals.Signal1;

public class CircuitStateChangedSignal extends Signal1
{
    public function CircuitStateChangedSignal()
    {
        super( Node );
    }

    public function dispatchCircuit( value:Node ):void
    {
        dispatch( value );
    }
}
}
