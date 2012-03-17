package circuit.signals
{
import circuit.api.Circuit;

import org.osflash.signals.Signal;

public class CircuitStateChangedSignal extends Signal
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
