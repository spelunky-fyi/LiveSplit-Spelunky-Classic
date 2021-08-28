state("Spelunky") {
    double level: "Spelunky.exe", 0x18F124, 0x4, 0x2b80;
    double totalTime: "Spelunky.exe", 0x18F124, 0x4, 0x24a0;
}

init {
    timer.CurrentTimingMethod = TimingMethod.GameTime;

    vars.furthestTotalTime = 0;
    vars.minimumStartTime = 100;
}

start {
    vars.furthestTotalTime = 0;
    if (current.totalTime > vars.minimumStartTime) {
        return true;
    }
}

update {
    if (current.totalTime > vars.furthestTotalTime) {
        vars.furthestTotalTime = current.totalTime;
    }
}

gameTime {
    return TimeSpan.FromMilliseconds(vars.furthestTotalTime);
}

isLoading {
    return (old.totalTime == current.totalTime);
}

reset {
    if (current.totalTime < vars.furthestTotalTime && current.totalTime > vars.minimumStartTime) {
        return true;
    }
}
