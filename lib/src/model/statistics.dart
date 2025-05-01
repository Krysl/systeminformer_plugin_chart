import 'dart:ffi';
import '../system_informer/generated_bindings.dart';

class SystemPerformanceInformation {
  final int idleProcessTime;
  final int ioReadTransferCount;
  final int ioWriteTransferCount;
  final int ioOtherTransferCount;
  final int ioReadOperationCount;
  final int ioWriteOperationCount;
  final int ioOtherOperationCount;
  final int availablePages;
  final int committedPages;
  final int commitLimit;
  final int peakCommitment;
  final int pageFaultCount;
  final int copyOnWriteCount;
  final int transitionCount;
  final int cacheTransitionCount;
  final int demandZeroCount;
  final int pageReadCount;
  final int pageReadIoCount;
  final int cacheReadCount;
  final int cacheIoCount;
  final int dirtyPagesWriteCount;
  final int dirtyWriteIoCount;
  final int mappedPagesWriteCount;
  final int mappedWriteIoCount;
  final int pagedPoolPages;
  final int nonPagedPoolPages;
  final int pagedPoolAllocs;
  final int pagedPoolFrees;
  final int nonPagedPoolAllocs;
  final int nonPagedPoolFrees;
  final int freeSystemPtes;
  final int residentSystemCodePage;
  final int totalSystemDriverPages;
  final int totalSystemCodePages;
  final int nonPagedPoolLookasideHits;
  final int pagedPoolLookasideHits;
  final int availablePagedPoolPages;
  final int residentSystemCachePage;
  final int residentPagedPoolPage;
  final int residentSystemDriverPage;
  final int ccFastReadNoWait;
  final int ccFastReadWait;
  final int ccFastReadResourceMiss;
  final int ccFastReadNotPossible;
  final int ccFastMdlReadNoWait;
  final int ccFastMdlReadWait;
  final int ccFastMdlReadResourceMiss;
  final int ccFastMdlReadNotPossible;
  final int ccMapDataNoWait;
  final int ccMapDataWait;
  final int ccMapDataNoWaitMiss;
  final int ccMapDataWaitMiss;
  final int ccPinMappedDataCount;
  final int ccPinReadNoWait;
  final int ccPinReadWait;
  final int ccPinReadNoWaitMiss;
  final int ccPinReadWaitMiss;
  final int ccCopyReadNoWait;
  final int ccCopyReadWait;
  final int ccCopyReadNoWaitMiss;
  final int ccCopyReadWaitMiss;
  final int ccMdlReadNoWait;
  final int ccMdlReadWait;
  final int ccMdlReadNoWaitMiss;
  final int ccMdlReadWaitMiss;
  final int ccReadAheadIos;
  final int ccLazyWriteIos;
  final int ccLazyWritePages;
  final int ccDataFlushes;
  final int ccDataPages;
  final int contextSwitches;
  final int firstLevelTbFills;
  final int secondLevelTbFills;
  final int systemCalls;
  final int ccTotalDirtyPages;
  final int ccDirtyPageThreshold;
  final int residentAvailablePages;
  final int sharedCommittedPages;
  final int mdlPagesAllocated;
  final int pfnDatabaseCommittedPages;
  final int systemPageTableCommittedPages;
  final int contiguousPagesAllocated;
  SystemPerformanceInformation({
    required this.idleProcessTime,
    required this.ioReadTransferCount,
    required this.ioWriteTransferCount,
    required this.ioOtherTransferCount,
    required this.ioReadOperationCount,
    required this.ioWriteOperationCount,
    required this.ioOtherOperationCount,
    required this.availablePages,
    required this.committedPages,
    required this.commitLimit,
    required this.peakCommitment,
    required this.pageFaultCount,
    required this.copyOnWriteCount,
    required this.transitionCount,
    required this.cacheTransitionCount,
    required this.demandZeroCount,
    required this.pageReadCount,
    required this.pageReadIoCount,
    required this.cacheReadCount,
    required this.cacheIoCount,
    required this.dirtyPagesWriteCount,
    required this.dirtyWriteIoCount,
    required this.mappedPagesWriteCount,
    required this.mappedWriteIoCount,
    required this.pagedPoolPages,
    required this.nonPagedPoolPages,
    required this.pagedPoolAllocs,
    required this.pagedPoolFrees,
    required this.nonPagedPoolAllocs,
    required this.nonPagedPoolFrees,
    required this.freeSystemPtes,
    required this.residentSystemCodePage,
    required this.totalSystemDriverPages,
    required this.totalSystemCodePages,
    required this.nonPagedPoolLookasideHits,
    required this.pagedPoolLookasideHits,
    required this.availablePagedPoolPages,
    required this.residentSystemCachePage,
    required this.residentPagedPoolPage,
    required this.residentSystemDriverPage,
    required this.ccFastReadNoWait,
    required this.ccFastReadWait,
    required this.ccFastReadResourceMiss,
    required this.ccFastReadNotPossible,
    required this.ccFastMdlReadNoWait,
    required this.ccFastMdlReadWait,
    required this.ccFastMdlReadResourceMiss,
    required this.ccFastMdlReadNotPossible,
    required this.ccMapDataNoWait,
    required this.ccMapDataWait,
    required this.ccMapDataNoWaitMiss,
    required this.ccMapDataWaitMiss,
    required this.ccPinMappedDataCount,
    required this.ccPinReadNoWait,
    required this.ccPinReadWait,
    required this.ccPinReadNoWaitMiss,
    required this.ccPinReadWaitMiss,
    required this.ccCopyReadNoWait,
    required this.ccCopyReadWait,
    required this.ccCopyReadNoWaitMiss,
    required this.ccCopyReadWaitMiss,
    required this.ccMdlReadNoWait,
    required this.ccMdlReadWait,
    required this.ccMdlReadNoWaitMiss,
    required this.ccMdlReadWaitMiss,
    required this.ccReadAheadIos,
    required this.ccLazyWriteIos,
    required this.ccLazyWritePages,
    required this.ccDataFlushes,
    required this.ccDataPages,
    required this.contextSwitches,
    required this.firstLevelTbFills,
    required this.secondLevelTbFills,
    required this.systemCalls,
    required this.ccTotalDirtyPages,
    required this.ccDirtyPageThreshold,
    required this.residentAvailablePages,
    required this.sharedCommittedPages,
    required this.mdlPagesAllocated,
    required this.pfnDatabaseCommittedPages,
    required this.systemPageTableCommittedPages,
    required this.contiguousPagesAllocated,
  });
  factory SystemPerformanceInformation.fromPointer(
    Pointer<SYSTEM_PERFORMANCE_INFORMATION> ptr,
  ) => SystemPerformanceInformation(
    idleProcessTime: ptr.ref.IdleProcessTime.QuadPart,
    ioReadTransferCount: ptr.ref.IoReadTransferCount.QuadPart,
    ioWriteTransferCount: ptr.ref.IoWriteTransferCount.QuadPart,
    ioOtherTransferCount: ptr.ref.IoOtherTransferCount.QuadPart,
    ioReadOperationCount: ptr.ref.IoReadOperationCount,
    ioWriteOperationCount: ptr.ref.IoWriteOperationCount,
    ioOtherOperationCount: ptr.ref.IoOtherOperationCount,
    availablePages: ptr.ref.AvailablePages,
    committedPages: ptr.ref.CommittedPages,
    commitLimit: ptr.ref.CommitLimit,
    peakCommitment: ptr.ref.PeakCommitment,
    pageFaultCount: ptr.ref.PageFaultCount,
    copyOnWriteCount: ptr.ref.CopyOnWriteCount,
    transitionCount: ptr.ref.TransitionCount,
    cacheTransitionCount: ptr.ref.CacheTransitionCount,
    demandZeroCount: ptr.ref.DemandZeroCount,
    pageReadCount: ptr.ref.PageReadCount,
    pageReadIoCount: ptr.ref.PageReadIoCount,
    cacheReadCount: ptr.ref.CacheReadCount,
    cacheIoCount: ptr.ref.CacheIoCount,
    dirtyPagesWriteCount: ptr.ref.DirtyPagesWriteCount,
    dirtyWriteIoCount: ptr.ref.DirtyWriteIoCount,
    mappedPagesWriteCount: ptr.ref.MappedPagesWriteCount,
    mappedWriteIoCount: ptr.ref.MappedWriteIoCount,
    pagedPoolPages: ptr.ref.PagedPoolPages,
    nonPagedPoolPages: ptr.ref.NonPagedPoolPages,
    pagedPoolAllocs: ptr.ref.PagedPoolAllocs,
    pagedPoolFrees: ptr.ref.PagedPoolFrees,
    nonPagedPoolAllocs: ptr.ref.NonPagedPoolAllocs,
    nonPagedPoolFrees: ptr.ref.NonPagedPoolFrees,
    freeSystemPtes: ptr.ref.FreeSystemPtes,
    residentSystemCodePage: ptr.ref.ResidentSystemCodePage,
    totalSystemDriverPages: ptr.ref.TotalSystemDriverPages,
    totalSystemCodePages: ptr.ref.TotalSystemCodePages,
    nonPagedPoolLookasideHits: ptr.ref.NonPagedPoolLookasideHits,
    pagedPoolLookasideHits: ptr.ref.PagedPoolLookasideHits,
    availablePagedPoolPages: ptr.ref.AvailablePagedPoolPages,
    residentSystemCachePage: ptr.ref.ResidentSystemCachePage,
    residentPagedPoolPage: ptr.ref.ResidentPagedPoolPage,
    residentSystemDriverPage: ptr.ref.ResidentSystemDriverPage,
    ccFastReadNoWait: ptr.ref.CcFastReadNoWait,
    ccFastReadWait: ptr.ref.CcFastReadWait,
    ccFastReadResourceMiss: ptr.ref.CcFastReadResourceMiss,
    ccFastReadNotPossible: ptr.ref.CcFastReadNotPossible,
    ccFastMdlReadNoWait: ptr.ref.CcFastMdlReadNoWait,
    ccFastMdlReadWait: ptr.ref.CcFastMdlReadWait,
    ccFastMdlReadResourceMiss: ptr.ref.CcFastMdlReadResourceMiss,
    ccFastMdlReadNotPossible: ptr.ref.CcFastMdlReadNotPossible,
    ccMapDataNoWait: ptr.ref.CcMapDataNoWait,
    ccMapDataWait: ptr.ref.CcMapDataWait,
    ccMapDataNoWaitMiss: ptr.ref.CcMapDataNoWaitMiss,
    ccMapDataWaitMiss: ptr.ref.CcMapDataWaitMiss,
    ccPinMappedDataCount: ptr.ref.CcPinMappedDataCount,
    ccPinReadNoWait: ptr.ref.CcPinReadNoWait,
    ccPinReadWait: ptr.ref.CcPinReadWait,
    ccPinReadNoWaitMiss: ptr.ref.CcPinReadNoWaitMiss,
    ccPinReadWaitMiss: ptr.ref.CcPinReadWaitMiss,
    ccCopyReadNoWait: ptr.ref.CcCopyReadNoWait,
    ccCopyReadWait: ptr.ref.CcCopyReadWait,
    ccCopyReadNoWaitMiss: ptr.ref.CcCopyReadNoWaitMiss,
    ccCopyReadWaitMiss: ptr.ref.CcCopyReadWaitMiss,
    ccMdlReadNoWait: ptr.ref.CcMdlReadNoWait,
    ccMdlReadWait: ptr.ref.CcMdlReadWait,
    ccMdlReadNoWaitMiss: ptr.ref.CcMdlReadNoWaitMiss,
    ccMdlReadWaitMiss: ptr.ref.CcMdlReadWaitMiss,
    ccReadAheadIos: ptr.ref.CcReadAheadIos,
    ccLazyWriteIos: ptr.ref.CcLazyWriteIos,
    ccLazyWritePages: ptr.ref.CcLazyWritePages,
    ccDataFlushes: ptr.ref.CcDataFlushes,
    ccDataPages: ptr.ref.CcDataPages,
    contextSwitches: ptr.ref.ContextSwitches,
    firstLevelTbFills: ptr.ref.FirstLevelTbFills,
    secondLevelTbFills: ptr.ref.SecondLevelTbFills,
    systemCalls: ptr.ref.SystemCalls,
    ccTotalDirtyPages: ptr.ref.CcTotalDirtyPages,
    ccDirtyPageThreshold: ptr.ref.CcDirtyPageThreshold,
    residentAvailablePages: ptr.ref.ResidentAvailablePages,
    sharedCommittedPages: ptr.ref.SharedCommittedPages,
    mdlPagesAllocated: ptr.ref.MdlPagesAllocated,
    pfnDatabaseCommittedPages: ptr.ref.PfnDatabaseCommittedPages,
    systemPageTableCommittedPages: ptr.ref.SystemPageTableCommittedPages,
    contiguousPagesAllocated: ptr.ref.ContiguousPagesAllocated,
  );
}

typedef Uint64Delta = ({int value, int delta});

class PluginSystemStatisticsInformation {
  final SystemPerformanceInformation performance;
  final int numberOfProcesses;
  final int numberOfThreads;
  final int numberOfHandles;
  final double cpuKernelUsage;
  final double cpuUserUsage;
  final Uint64Delta ioReadDelta;
  final Uint64Delta ioWriteDelta;
  final Uint64Delta ioOtherDelta;
  final int commitPages;
  final int physicalPages;
  final HANDLE maxCpuProcessId;
  final HANDLE maxIoProcessId;
  final PPH_CIRCULAR_BUFFER_FLOAT cpuKernelHistory;
  final PPH_CIRCULAR_BUFFER_FLOAT cpuUserHistory;
  final Pointer<PPH_CIRCULAR_BUFFER_FLOAT> cpusKernelHistory;
  final Pointer<PPH_CIRCULAR_BUFFER_FLOAT> cpusUserHistory;
  final PPH_CIRCULAR_BUFFER_ULONG64 ioReadHistory;
  final PPH_CIRCULAR_BUFFER_ULONG64 ioWriteHistory;
  final PPH_CIRCULAR_BUFFER_ULONG64 ioOtherHistory;
  final PPH_CIRCULAR_BUFFER_ULONG commitHistory;
  final PPH_CIRCULAR_BUFFER_ULONG physicalHistory;
  final PPH_CIRCULAR_BUFFER_ULONG maxCpuHistory;
  final PPH_CIRCULAR_BUFFER_ULONG maxIoHistory;
  final PPH_CIRCULAR_BUFFER_FLOAT maxCpuUsageHistory;
  final PPH_CIRCULAR_BUFFER_ULONG64 maxIoReadOtherHistory;
  final PPH_CIRCULAR_BUFFER_ULONG64 maxIoWriteHistory;
  PluginSystemStatisticsInformation({
    required this.performance,
    required this.numberOfProcesses,
    required this.numberOfThreads,
    required this.numberOfHandles,
    required this.cpuKernelUsage,
    required this.cpuUserUsage,
    required this.ioReadDelta,
    required this.ioWriteDelta,
    required this.ioOtherDelta,
    required this.commitPages,
    required this.physicalPages,
    required this.maxCpuProcessId,
    required this.maxIoProcessId,
    required this.cpuKernelHistory,
    required this.cpuUserHistory,
    required this.cpusKernelHistory,
    required this.cpusUserHistory,
    required this.ioReadHistory,
    required this.ioWriteHistory,
    required this.ioOtherHistory,
    required this.commitHistory,
    required this.physicalHistory,
    required this.maxCpuHistory,
    required this.maxIoHistory,
    required this.maxCpuUsageHistory,
    required this.maxIoReadOtherHistory,
    required this.maxIoWriteHistory,
  });
  factory PluginSystemStatisticsInformation.fromPointer(
    Pointer<PH_PLUGIN_SYSTEM_STATISTICS> ptr,
  ) {
    return PluginSystemStatisticsInformation(
      performance: SystemPerformanceInformation.fromPointer(
        ptr.ref.Performance,
      ),
      numberOfProcesses: ptr.ref.NumberOfProcesses,
      numberOfThreads: ptr.ref.NumberOfThreads,
      numberOfHandles: ptr.ref.NumberOfHandles,
      cpuKernelUsage: ptr.ref.CpuKernelUsage,
      cpuUserUsage: ptr.ref.CpuUserUsage,
      ioReadDelta: (
        value: ptr.ref.IoReadDelta.Value,
        delta: ptr.ref.IoReadDelta.Delta,
      ),
      ioWriteDelta: (
        value: ptr.ref.IoWriteDelta.Value,
        delta: ptr.ref.IoWriteDelta.Delta,
      ),
      ioOtherDelta: (
        value: ptr.ref.IoOtherDelta.Value,
        delta: ptr.ref.IoOtherDelta.Delta,
      ),
      commitPages: ptr.ref.CommitPages,
      physicalPages: ptr.ref.PhysicalPages,
      maxCpuProcessId: ptr.ref.MaxCpuProcessId,
      maxIoProcessId: ptr.ref.MaxIoProcessId,
      cpuKernelHistory: ptr.ref.CpuKernelHistory,
      cpuUserHistory: ptr.ref.CpuUserHistory,
      cpusKernelHistory: ptr.ref.CpusKernelHistory,
      cpusUserHistory: ptr.ref.CpusUserHistory,
      ioReadHistory: ptr.ref.IoReadHistory,
      ioWriteHistory: ptr.ref.IoWriteHistory,
      ioOtherHistory: ptr.ref.IoOtherHistory,
      commitHistory: ptr.ref.CommitHistory,
      physicalHistory: ptr.ref.PhysicalHistory,
      maxCpuHistory: ptr.ref.MaxCpuHistory,
      maxIoHistory: ptr.ref.MaxIoHistory,
      maxCpuUsageHistory: ptr.ref.MaxCpuUsageHistory,
      maxIoReadOtherHistory: ptr.ref.MaxIoReadOtherHistory,
      maxIoWriteHistory: ptr.ref.MaxIoWriteHistory,
    );
  }
}
