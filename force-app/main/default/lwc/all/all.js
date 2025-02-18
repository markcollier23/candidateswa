import { LightningElement, track} from 'lwc'; 
export default class all extends LightningElement { 
    @track value; 
    @track options = [  
        { label: 'all', value: 'all' }, 
        { label: 'apexImperativeMethod', value: 'apexImperativeMethod' }, 
        { label: 'apexImperativeMethodWithComplexParams', value: 'apexImperativeMethodWithComplexParams' }, 
        { label: 'apexImperativeMethodWithParams', value: 'apexImperativeMethodWithParams' }, 
        { label: 'apexStaticSchema', value: 'apexStaticSchema' }, 
        { label: 'apexWireMethodToFunction', value: 'apexWireMethodToFunction' }, 
        { label: 'apexWireMethodToProperty', value: 'apexWireMethodToProperty' }, 
        { label: 'apexWireMethodWithComplexParams', value: 'apexWireMethodWithComplexParams' }, 
        { label: 'apexWireMethodWithParams', value: 'apexWireMethodWithParams' }, 
        { label: 'apiFunction', value: 'apiFunction' }, 
        { label: 'apiProperty', value: 'apiProperty' }, 
        { label: 'apiSetterGetter', value: 'apiSetterGetter' }, 
        { label: 'auraPubsub', value: 'auraPubsub' }, 
        { label: 'bearList', value: 'bearList' }, 
        { label: 'bearLocation', value: 'bearLocation' }, 
        { label: 'bearSupervisor', value: 'bearSupervisor' }, 
        { label: 'categoryFilter', value: 'categoryFilter' }, 
        { label: 'chartBar', value: 'chartBar' }, 
        { label: 'clock', value: 'clock' }, 
        { label: 'compositionBasics', value: 'compositionBasics' }, 
        { label: 'compositionContactSearch', value: 'compositionContactSearch' }, 
        { label: 'compositionIteration', value: 'compositionIteration' }, 
        { label: 'compositionWithAppBuilder', value: 'compositionWithAppBuilder' }, 
        { label: 'contactList', value: 'contactList' }, 
        { label: 'contactListItem', value: 'contactListItem' }, 
        { label: 'contactListItemBubbling', value: 'contactListItemBubbling' }, 
        { label: 'contactTile', value: 'contactTile' }, 
        { label: 'errorPanel', value: 'errorPanel' }, 
        { label: 'eventBubbling', value: 'eventBubbling' }, 
        { label: 'eventSimple', value: 'eventSimple' }, 
        { label: 'eventWithData', value: 'eventWithData' }, 
        { label: 'hello', value: 'hello' }, 
        { label: 'helloBinding', value: 'helloBinding' }, 
        { label: 'helloConditionalRendering', value: 'helloConditionalRendering' }, 
        { label: 'helloExpressions', value: 'helloExpressions' }, 
        { label: 'helloForEach', value: 'helloForEach' }, 
        { label: 'helloIterator', value: 'helloIterator' }, 
        { label: 'helloWebComponent', value: 'helloWebComponent' }, 
        { label: 'lds', value: 'lds' }, 
        { label: 'ldsCreateRecord', value: 'ldsCreateRecord' }, 
        { label: 'ldsDeleteRecord', value: 'ldsDeleteRecord' }, 
        { label: 'ldsUtils', value: 'ldsUtils' }, 
        { label: 'libsChartjs', value: 'libsChartjs' }, 
        { label: 'libsD3', value: 'libsD3' }, 
        { label: 'libsMomentjs', value: 'libsMomentjs' }, 
        { label: 'miscContentAsset', value: 'miscContentAsset' }, 
        { label: 'miscDomQuery', value: 'miscDomQuery' }, 
        { label: 'miscGetUserId', value: 'miscGetUserId' }, 
        { label: 'miscModal', value: 'miscModal' }, 
        { label: 'miscMultipleTemplates', value: 'miscMultipleTemplates' }, 
        { label: 'miscNotification', value: 'miscNotification' }, 
        { label: 'miscRestApiCall', value: 'miscRestApiCall' }, 
        { label: 'miscSharedJavaScript', value: 'miscSharedJavaScript' }, 
        { label: 'miscStaticResource', value: 'miscStaticResource' }, 
        { label: 'modal', value: 'modal' }, 
        { label: 'mortgage', value: 'mortgage' }, 
        { label: 'navToChatterHome', value: 'navToChatterHome' }, 
        { label: 'navToFilesHome', value: 'navToFilesHome' }, 
        { label: 'navToHelloTab', value: 'navToHelloTab' }, 
        { label: 'navToHome', value: 'navToHome' }, 
        { label: 'navToListView', value: 'navToListView' }, 
        { label: 'navToNewRecord', value: 'navToNewRecord' }, 
        { label: 'navToNewRecordWithDefaults', value: 'navToNewRecordWithDefaults' }, 
        { label: 'navToRecord', value: 'navToRecord' }, 
        { label: 'navToRelatedList', value: 'navToRelatedList' }, 
        { label: 'paginator', value: 'paginator' }, 
        { label: 'pubsub', value: 'pubsub' }, 
        { label: 'pubsubContactDetails', value: 'pubsubContactDetails' }, 
        { label: 'pubsubContactList', value: 'pubsubContactList' }, 
        { label: 'pubsubSearchBar', value: 'pubsubSearchBar' }, 
        { label: 'recordEditFormDynamicContact', value: 'recordEditFormDynamicContact' }, 
        { label: 'recordEditFormStaticContact', value: 'recordEditFormStaticContact' }, 
        { label: 'recordFormDynamicContact', value: 'recordFormDynamicContact' }, 
        { label: 'recordFormStaticContact', value: 'recordFormStaticContact' }, 
        { label: 'recordViewFormDynamicContact', value: 'recordViewFormDynamicContact' }, 
        { label: 'recordViewFormStaticContact', value: 'recordViewFormStaticContact' }, 
        { label: 'todoList', value: 'todoList' }, 
        { label: 'viewSource', value: 'viewSource' }, 
        { label: 'wireCurrentPageReference', value: 'wireCurrentPageReference' }, 
        { label: 'wireGetObjectInfo', value: 'wireGetObjectInfo' }, 
        { label: 'wireGetPicklistValues', value: 'wireGetPicklistValues' }, 
        { label: 'wireGetPicklistValuesByRecordType', value: 'wireGetPicklistValuesByRecordType' }, 
        { label: 'wireGetRecordDynamicContact', value: 'wireGetRecordDynamicContact' }, 
        { label: 'wireGetRecordStaticContact', value: 'wireGetRecordStaticContact' }, 
        { label: 'wireGetRecordUser', value: 'wireGetRecordUser' }, 
        { label: 'wireListView', value: 'wireListView' }, 
    ]; 
    handleChange(event){ 
        this.value = event.target.value; 
    } 
    get all(){ 
        return this.value=='all'; 
    } 
    get apexImperativeMethod(){ 
        return this.value=='apexImperativeMethod'; 
    } 
    get apexImperativeMethodWithComplexParams(){ 
        return this.value=='apexImperativeMethodWithComplexParams'; 
    } 
    get apexImperativeMethodWithParams(){ 
        return this.value=='apexImperativeMethodWithParams'; 
    } 
    get apexStaticSchema(){ 
        return this.value=='apexStaticSchema'; 
    } 
    get apexWireMethodToFunction(){ 
        return this.value=='apexWireMethodToFunction'; 
    } 
    get apexWireMethodToProperty(){ 
        return this.value=='apexWireMethodToProperty'; 
    } 
    get apexWireMethodWithComplexParams(){ 
        return this.value=='apexWireMethodWithComplexParams'; 
    } 
    get apexWireMethodWithParams(){ 
        return this.value=='apexWireMethodWithParams'; 
    } 
    get apiFunction(){ 
        return this.value=='apiFunction'; 
    } 
    get apiProperty(){ 
        return this.value=='apiProperty'; 
    } 
    get apiSetterGetter(){ 
        return this.value=='apiSetterGetter'; 
    } 
    get auraPubsub(){ 
        return this.value=='auraPubsub'; 
    } 
    get bearList(){ 
        return this.value=='bearList'; 
    } 
    get bearLocation(){ 
        return this.value=='bearLocation'; 
    } 
    get bearSupervisor(){ 
        return this.value=='bearSupervisor'; 
    } 
    get categoryFilter(){ 
        return this.value=='categoryFilter'; 
    } 
    get chartBar(){ 
        return this.value=='chartBar'; 
    } 
    get clock(){ 
        return this.value=='clock'; 
    } 
    get compositionBasics(){ 
        return this.value=='compositionBasics'; 
    } 
    get compositionContactSearch(){ 
        return this.value=='compositionContactSearch'; 
    } 
    get compositionIteration(){ 
        return this.value=='compositionIteration'; 
    } 
    get compositionWithAppBuilder(){ 
        return this.value=='compositionWithAppBuilder'; 
    } 
    get contactList(){ 
        return this.value=='contactList'; 
    } 
    get contactListItem(){ 
        return this.value=='contactListItem'; 
    } 
    get contactListItemBubbling(){ 
        return this.value=='contactListItemBubbling'; 
    } 
    get contactTile(){ 
        return this.value=='contactTile'; 
    } 
    get errorPanel(){ 
        return this.value=='errorPanel'; 
    } 
    get eventBubbling(){ 
        return this.value=='eventBubbling'; 
    } 
    get eventSimple(){ 
        return this.value=='eventSimple'; 
    } 
    get eventWithData(){ 
        return this.value=='eventWithData'; 
    } 
    get hello(){ 
        return this.value=='hello'; 
    } 
    get helloBinding(){ 
        return this.value=='helloBinding'; 
    } 
    get helloConditionalRendering(){ 
        return this.value=='helloConditionalRendering'; 
    } 
    get helloExpressions(){ 
        return this.value=='helloExpressions'; 
    } 
    get helloForEach(){ 
        return this.value=='helloForEach'; 
    } 
    get helloIterator(){ 
        return this.value=='helloIterator'; 
    } 
    get helloWebComponent(){ 
        return this.value=='helloWebComponent'; 
    } 
    get lds(){ 
        return this.value=='lds'; 
    } 
    get ldsCreateRecord(){ 
        return this.value=='ldsCreateRecord'; 
    } 
    get ldsDeleteRecord(){ 
        return this.value=='ldsDeleteRecord'; 
    } 
    get ldsUtils(){ 
        return this.value=='ldsUtils'; 
    } 
    get libsChartjs(){ 
        return this.value=='libsChartjs'; 
    } 
    get libsD3(){ 
        return this.value=='libsD3'; 
    } 
    get libsMomentjs(){ 
        return this.value=='libsMomentjs'; 
    } 
    get miscContentAsset(){ 
        return this.value=='miscContentAsset'; 
    } 
    get miscDomQuery(){ 
        return this.value=='miscDomQuery'; 
    } 
    get miscGetUserId(){ 
        return this.value=='miscGetUserId'; 
    } 
    get miscModal(){ 
        return this.value=='miscModal'; 
    } 
    get miscMultipleTemplates(){ 
        return this.value=='miscMultipleTemplates'; 
    } 
    get miscNotification(){ 
        return this.value=='miscNotification'; 
    } 
    get miscRestApiCall(){ 
        return this.value=='miscRestApiCall'; 
    } 
    get miscSharedJavaScript(){ 
        return this.value=='miscSharedJavaScript'; 
    } 
    get miscStaticResource(){ 
        return this.value=='miscStaticResource'; 
    } 
    get modal(){ 
        return this.value=='modal'; 
    } 
    get mortgage(){ 
        return this.value=='mortgage'; 
    } 
    get navToChatterHome(){ 
        return this.value=='navToChatterHome'; 
    } 
    get navToFilesHome(){ 
        return this.value=='navToFilesHome'; 
    } 
    get navToHelloTab(){ 
        return this.value=='navToHelloTab'; 
    } 
    get navToHome(){ 
        return this.value=='navToHome'; 
    } 
    get navToListView(){ 
        return this.value=='navToListView'; 
    } 
    get navToNewRecord(){ 
        return this.value=='navToNewRecord'; 
    } 
    get navToNewRecordWithDefaults(){ 
        return this.value=='navToNewRecordWithDefaults'; 
    } 
    get navToRecord(){ 
        return this.value=='navToRecord'; 
    } 
    get navToRelatedList(){ 
        return this.value=='navToRelatedList'; 
    } 
    get paginator(){ 
        return this.value=='paginator'; 
    } 
    get pubsub(){ 
        return this.value=='pubsub'; 
    } 
    get pubsubContactDetails(){ 
        return this.value=='pubsubContactDetails'; 
    } 
    get pubsubContactList(){ 
        return this.value=='pubsubContactList'; 
    } 
    get pubsubSearchBar(){ 
        return this.value=='pubsubSearchBar'; 
    } 
    get recordEditFormDynamicContact(){ 
        return this.value=='recordEditFormDynamicContact'; 
    } 
    get recordEditFormStaticContact(){ 
        return this.value=='recordEditFormStaticContact'; 
    } 
    get recordFormDynamicContact(){ 
        return this.value=='recordFormDynamicContact'; 
    } 
    get recordFormStaticContact(){ 
        return this.value=='recordFormStaticContact'; 
    } 
    get recordViewFormDynamicContact(){ 
        return this.value=='recordViewFormDynamicContact'; 
    } 
    get recordViewFormStaticContact(){ 
        return this.value=='recordViewFormStaticContact'; 
    } 
    get todoList(){ 
        return this.value=='todoList'; 
    } 
    get viewSource(){ 
        return this.value=='viewSource'; 
    } 
    get wireCurrentPageReference(){ 
        return this.value=='wireCurrentPageReference'; 
    } 
    get wireGetObjectInfo(){ 
        return this.value=='wireGetObjectInfo'; 
    } 
    get wireGetPicklistValues(){ 
        return this.value=='wireGetPicklistValues'; 
    } 
    get wireGetPicklistValuesByRecordType(){ 
        return this.value=='wireGetPicklistValuesByRecordType'; 
    } 
    get wireGetRecordDynamicContact(){ 
        return this.value=='wireGetRecordDynamicContact'; 
    } 
    get wireGetRecordStaticContact(){ 
        return this.value=='wireGetRecordStaticContact'; 
    } 
    get wireGetRecordUser(){ 
        return this.value=='wireGetRecordUser'; 
    } 
    get wireListView(){ 
        return this.value=='wireListView'; 
    } 
}