package circuit.signals
{
import circuit.api.Edge;

import net.richardlord.ash.signals.Signal1;

public class BreakerStateChangedSignal extends Signal1
{
    public function BreakerStateChangedSignal()
    {
        super( Edge );
    }

    public function dispatchBreaker( value:Edge ):void
    {
        dispatch( value );
    }
}
}
