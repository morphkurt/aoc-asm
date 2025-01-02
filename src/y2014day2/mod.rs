#[link(name = "aoc.a")]
extern "C" {
    fn y2014_day2_solve1(s: *const u8, len: usize) -> i64;
    fn y2014_day2_solve2(s: *const u8, len: usize) -> i64;
}

pub fn part1(input: &str) -> i64 {
    let input_ptr: *const u8 = input.as_ptr();
    // Get the length of the string
    let len = input.len();
    unsafe {
        let r = y2014_day2_solve1(input_ptr, len);
        return r;
    };
}

pub fn part2(input: &str) -> i64 {
    let input_ptr: *const u8 = input.as_ptr();
    // Get the length of the string
    let len = input.len();
    unsafe {
        let r = y2014_day2_solve2(input_ptr, len);
        return r;
    };
}

#[cfg(test)]
mod tests {
    use super::*;
    const EXAMPLE: &str = "(())()))";

    #[test]
    fn test_part1() {
        let result = part1(EXAMPLE);
        assert_eq!(result, -2);
    }

    #[test]
    fn test_part2() {
        let result = part2(EXAMPLE);
        assert_eq!(result, 1);
    }
}
