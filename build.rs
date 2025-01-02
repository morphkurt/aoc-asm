use walkdir::WalkDir;
const YEARS: &[&str] = &["src"];

fn main() {
    nasm_rs::compile_library_args(
        "aoc.a",
        &collect_asm_files(YEARS)
            .iter()
            .map(|s| s.as_str())
            .collect::<Vec<&str>>(),&["-F", "dwarf", "-g" ,"-f" ,"macho64"]
    )
    .unwrap();
}

fn collect_asm_files(dir: &[&str]) -> Vec<String> {
    let asm_files: Vec<String> = 
        dir.iter().flat_map(|f|  WalkDir::new(f)
        .into_iter()
        .filter_map(|entry| entry.ok()) // Ignore errors
        .filter(|entry| entry.path().is_file()) // Only files
        .filter_map(|entry| entry.path().to_str().map(|s| s.to_string())) // Convert to String
        .filter(|path| path.ends_with(".asm")) // Check for .asm extension
        .collect::<Vec<String>>()).collect();
       
    asm_files
}
