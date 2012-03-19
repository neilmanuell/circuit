package circuit.signals
{
import circuit.api.Circuit;

import net.richardlord.ash.signals.Signal1;

public class CircuitStateChangedSignal extends Signal1
{
    public function CircuitStateChangedSignal(  )
    {
        super( Circuit );
    }

    public function dispatchCircuit( value:Circuit ):void
    {
        dispatch( value );
    }
}
}
