export function usePwa() {
    return {
        needRefresh: { subscribe: (fn: any) => { fn(false); return () => {}; } },
        updateServiceWorker: async () => {},
        needRefreshByStorage: false
    };
}

