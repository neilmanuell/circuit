package circuit.signals
{
import circuit.api.Breaker;

import net.richardlord.ash.signals.Signal1;

public class BreakerStateChangedSignal extends Signal1
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
