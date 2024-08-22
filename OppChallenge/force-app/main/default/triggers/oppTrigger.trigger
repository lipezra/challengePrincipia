trigger oppTrigger on Opportunity (before insert, before update) {
    new oppTriggerHandler().run();
}