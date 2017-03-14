export declare class Console {
    private static quiet;
    private static debug;
    private static verbose;
    static Log(text: any): void;
    private static readonly Timestamp;
    static Debug(text: any): void;
    static Verbose(text: any): void;
    static Error(text: any): void;
    static Exit(reason: any): void;
}
