package circuit.signals
{
import circuit.api.Breaker;

import org.osflash.signals.Signal;

public class BreakerStateChangedSignal extends Signal
{
    public function BreakerStateChangedSignal(  )
    {
        super( Breaker );
    }

    public function dispatchBreaker( value:Breaker ):void
    {
        dispatch( value );
    }
}
}
